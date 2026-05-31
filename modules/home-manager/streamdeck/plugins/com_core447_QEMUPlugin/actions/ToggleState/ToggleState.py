# Import StreamController modules
from src.backend.PluginManager.ActionBase import ActionBase
from src.backend.DeckManagement.DeckController import DeckController
from src.backend.PageManagement.Page import Page
from src.backend.PluginManager.PluginBase import PluginBase
from plugins.com_core447_QEMUPlugin.QEMUController import QEMUController
from GtkHelper.GtkHelper import ComboRow

# Import python modules
import os
from loguru import logger as log

# Import gtk modules - used for the config rows
import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw, Pango

class ToggleState(ActionBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.controller = QEMUController()
        
    def on_ready(self) -> None:
        self.set_status_image()

    def on_update(self) -> None:
        self.set_status_image()

    def on_tick(self) -> None:
        self.set_status_image()

    def get_is_running(self) -> bool:
        settings = self.get_settings()
        vm_name = settings.get("vm_name", "")
        uri = settings.get("uri", "")
        if not vm_name or not uri:
            return False
        
        return self.controller.get_vm_status(vm_name, uri)['status'] == 'Running'
    
    def set_status_image(self) -> None:
        running = self.get_is_running()
        if running:
            icon_path = os.path.join(self.plugin_base.PATH, "assets", "running.png")
        else:
            icon_path = os.path.join(self.plugin_base.PATH, "assets", "stopped.png")
        self.set_media(media_path=icon_path, size=0.75)
        
    def on_key_down(self) -> None:
        log.debug("Key down")
        try:
            # Get the selected VM
            settings = self.get_settings()

            vm_name = settings.get("vm_name", "")
            uri = settings.get("uri", "")

            if not vm_name or not uri:
                log.error("No VM selected")
                return
            
            # Toggle the VM state
            vm_status = self.controller.get_vm_status(vm_name, uri)
            
            if vm_status['status'] == 'Running':
                log.info(f"Stopping VM {vm_name} with URI {uri}")
                self.controller.stop_vm(vm_name, force=False, uri=uri)
            else:
                log.info(f"Starting VM {vm_name}")
                self.controller.start_vm(vm_name, uri=uri)
        except Exception as e:
            log.error(f"Error toggling VM state: {e}")

    def get_config_rows(self):
        try:
            self.vm_model = Gtk.ListStore.new([str, str])  # VM name, URI
            self.vm_model_display_name = Gtk.ListStore.new([str])  # Display name only for the UI
            self.vm_row = ComboRow(model=self.vm_model_display_name, title="VM")

            self.vm_cell_renderer = Gtk.CellRendererText(ellipsize=Pango.EllipsizeMode.END, max_width_chars=60)
            self.vm_row.combo_box.pack_start(self.vm_cell_renderer, True)
            self.vm_row.combo_box.add_attribute(self.vm_cell_renderer, "text", 0)

            self.load_vm_model()
            self.load_from_settings()
            self.vm_row.combo_box.connect("changed", self.on_vm_selection_change)

            return [self.vm_row]
        except Exception as e:
            log.error(f"Error creating config rows: {e}")
            return []
        
    def on_vm_selection_change(self, combo, *args):
        active_id = combo.get_active()
        if active_id >= 0:
            vm_name = self.vm_model[active_id][0]
            uri = self.vm_model[active_id][1]

            settings = self.get_settings()
            settings["vm_name"] = vm_name
            settings["uri"] = uri
            print(f"Selected VM: {vm_name}, URI: {uri}")
            self.set_settings(settings)

    def load_from_settings(self):
        settings = self.get_settings()
        vm_name = settings.get("vm_name", "")
        uri = settings.get("uri", "")

        for i, vm in enumerate(self.vm_model):
            if vm[0] == vm_name and vm[1] == uri:
                self.vm_row.combo_box.set_active(i)
                return

    def load_vm_model(self):
        try:
            # Clear the models first
            self.vm_model.clear()
            self.vm_model_display_name.clear()
            
            # Get VMs from controller
            vms = self.controller.get_vms(show_all_connections=True)
            
            # Add QEMU VMs
            for vm in vms["qemu"]:
                # Check if vm is a dictionary with a name key
                if isinstance(vm, dict) and "name" in vm:
                    vm_name = vm["name"]
                    self.vm_model.append([vm_name, "qemu"])
                    self.vm_model_display_name.append([f"{vm_name} (QEMU)"])
            
            # Add libvirt VMs
            for uri, vm_list in vms["libvirt"].items():
                for vm in vm_list:
                    if isinstance(vm, dict) and "name" in vm:
                        vm_name = vm["name"]
                        self.vm_model.append([vm_name, uri])
                        self.vm_model_display_name.append([f"{vm_name} ({uri})"])
        except Exception as e:
            log.error(f"Error loading VM model: {e}")