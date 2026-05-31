import re
import os
import signal
import subprocess
import time
import gi
gi.require_version("Xdp", "1.0")
from gi.repository import Xdp
from loguru import logger as log

class QEMUController:
    """
    A class to manage QEMU virtual machines with support for both direct QEMU
    processes and libvirt-managed VMs.
    """
    
    def __init__(self, qemu_bin_path="qemu-system-x86_64", libvirt_uri=None):
        """
        Initialize the QemuVM manager.
        
        Args:
            qemu_bin_path (str): Path to the QEMU binary.
            libvirt_uri (str, optional): URI for libvirt connection (e.g., 'qemu:///system')
                                        If None, will try to detect the default.
        """
        portal = Xdp.Portal.new()
        self.flatpak = portal.running_under_flatpak()
        self.qemu_bin_path = qemu_bin_path
        self.libvirt_available = self._check_libvirt()
        self.libvirt_uri = libvirt_uri
        self.default_uri = self._get_default_uri() if self.libvirt_available else None
    
    @log.catch
    def _run_command(self, command: list[str]) -> subprocess.Popen:
        """Run a command with proper error handling"""
        if self.flatpak:
            command.insert(0, "flatpak-spawn")
            command.insert(1, "--host")
        try:
            return subprocess.Popen(command, stdout=subprocess.PIPE, cwd="/")
        except Exception as e:
            log.error(f"An error occurred while running {command}: {e}")
            return None
    
    def _check_libvirt(self):
        """Check if libvirt tools are available"""
        try:
            process = self._run_command(["which", "virsh"])
            if process:
                result = process.wait()
                return result == 0
            return False
        except Exception as e:
            log.error(f"Error checking libvirt availability: {e}")
            return False
    
    def _get_default_uri(self):
        """Get the default URI used by libvirt"""
        try:
            process = self._run_command(["virsh", "uri"])
            if process:
                stdout, _ = process.communicate()
                result = process.wait()
                if result == 0:
                    return stdout.decode().strip()
            return None
        except Exception as e:
            log.error(f"Error getting default URI: {e}")
            return None
    
    def _get_all_connections(self):
        """Get all available libvirt connections"""
        connections = []
        try:
            # Try common URIs
            uris = [
                "qemu:///system",    # System-level VMs
                "qemu:///session",   # User-level VMs
                self.default_uri     # Default connection
            ]
            
            for uri in uris:
                if uri and uri not in connections:
                    connections.append(uri)
            
            return connections
        except Exception as e:
            log.error(f"Error getting connections: {e}")
            return [self.default_uri] if self.default_uri else []
    
    def get_vms(self, show_all_connections=True):
        """
        Get a list of all VMs (both direct QEMU and libvirt-managed).
        
        Args:
            show_all_connections (bool): If True, list VMs from all possible libvirt connections.
        
        Returns:
            dict: Dictionary with 'qemu' and 'libvirt' keys, each containing VM information.
        """
        vms = {'qemu': [], 'libvirt': {}}
        
        # Get libvirt VMs first if available
        if self.libvirt_available:
            try:
                connections = self._get_all_connections() if show_all_connections else [self.libvirt_uri or self.default_uri]
                
                for uri in connections:
                    if not uri:
                        continue
                    
                    vms['libvirt'][uri] = []
                    
                    # Get running VMs
                    process = self._run_command(["virsh", "-c", uri, "list", "--name"])
                    if process:
                        stdout, _ = process.communicate()
                        result = process.wait()
                        if result == 0:
                            running_vms = [vm for vm in stdout.decode().splitlines() if vm.strip()]
                            for vm in running_vms:
                                vms['libvirt'][uri].append({"name": vm, "status": "Running"})
                    
                    # Get stopped VMs
                    process = self._run_command(["virsh", "-c", uri, "list", "--inactive", "--name"])
                    if process:
                        stdout, _ = process.communicate()
                        result = process.wait()
                        if result == 0:
                            stopped_vms = [vm for vm in stdout.decode().splitlines() if vm.strip()]
                            for vm in stopped_vms:
                                vms['libvirt'][uri].append({"name": vm, "status": "Stopped"})
            
            except Exception as e:
                log.error(f"Error retrieving libvirt VM list: {e}")
        
        # Now get direct QEMU VMs - exclude libvirt managed VMs
        try:
            process = self._run_command(["pgrep", "-fa", "qemu"])
            if process:
                stdout, _ = process.communicate()
                result = process.wait()
                
                # Get list of libvirt VM names for exclusion
                libvirt_vm_names = set()
                for uri_vms in vms['libvirt'].values():
                    for vm in uri_vms:
                        libvirt_vm_names.add(vm["name"])
                
                for line in stdout.decode().splitlines():
                    # Look for the pattern: -name guest=
                    match = re.search(r'-name\\s+guest=([^,]+)', line)
                    if match:
                        vm_name = match.group(1)
                        # Only add if not already managed by libvirt
                        if vm_name not in libvirt_vm_names:
                            vms['qemu'].append({"name": vm_name, "status": "Running"})
        except Exception as e:
            log.error(f"Error retrieving QEMU VM list: {e}")
        
        return vms
    
    def get_vm_status(self, vm_name, uri):
        """
        Check if a VM is running.
        
        Args:
            vm_name (str): Name of the VM to check.
            uri (str): URI identifier - 'qemu' for direct QEMU VMs or libvirt URI.
            
        Returns:
            dict: Dictionary with status information including:
                  - 'status': 'Running', 'Stopped', or 'Unknown'
                  - 'type': 'qemu', 'libvirt', or None
                  - 'uri': URI if libvirt VM
        """
        result = {'status': 'Unknown', 'type': None, 'uri': None}
        
        # Handle direct QEMU VMs
        if uri == 'qemu':
            result['type'] = 'qemu'
            try:
                process = self._run_command(["pgrep", "-f", f"qemu.*{vm_name}"])
                if process:
                    stdout, _ = process.communicate()
                    cmd_result = process.wait()
                    
                    if cmd_result == 0:
                        result['status'] = 'Running'
                    else:
                        result['status'] = 'Stopped'
                    
                    return result
            except Exception as e:
                log.error(f"Error checking QEMU VM status: {e}")
                return result
        
        # Handle libvirt VMs
        elif self.libvirt_available and uri != 'qemu':
            result['type'] = 'libvirt'
            result['uri'] = uri
            
            try:
                # Check if VM exists in libvirt
                cmd = ["virsh", "-c", uri, "domstate", vm_name]
                process = self._run_command(cmd)
                if process:
                    stdout, _ = process.communicate()
                    cmd_result = process.wait()
                    
                    if cmd_result == 0:
                        state = stdout.decode().strip().lower()
                        
                        if state == 'running':
                            result['status'] = 'Running'
                        elif state in ['shut off', 'inactive', 'paused', 'suspended']:
                            result['status'] = 'Stopped'
                        
                        return result
            except Exception as e:
                log.error(f"Error checking libvirt VM status: {e}")
        
        return result
    
    def start_vm(self, vm_name, uri, vm_config=None):
        """
        Start a VM (either direct QEMU or libvirt-managed).
        
        Args:
            vm_name (str): Name of the VM to start.
            uri (str): URI identifier - 'qemu' for direct QEMU VMs or libvirt URI.
            vm_config (dict, optional): Configuration parameters for direct QEMU VMs.
                                       Ignored for libvirt VMs.
                                       
        Returns:
            bool: True if VM was started successfully, False otherwise.
        """
        # Check current status
        status_info = self.get_vm_status(vm_name, uri)
        
        # If already running, nothing to do
        if status_info['status'] == 'Running':
            log.info(f"VM {vm_name} is already running")
            return True
        
        # Handle libvirt VMs
        if uri != 'qemu' and self.libvirt_available:
            try:
                process = self._run_command(["virsh", "-c", uri, "start", vm_name])
                if process:
                    stdout, stderr = process.communicate()
                    cmd_result = process.wait()
                    
                    if cmd_result == 0:
                        time.sleep(2)  # Give it a moment to start
                        return self.get_vm_status(vm_name, uri)['status'] == 'Running'
                    
                    log.error(f"Failed to start libvirt VM {vm_name}: {stderr.decode() if stderr else ''}")
                    return False
                return False
            except Exception as e:
                log.error(f"Error starting libvirt VM {vm_name}: {e}")
                return False
        
        # Handle direct QEMU VMs
        elif uri == 'qemu':
            try:
                # Basic command to start a VM
                cmd = [self.qemu_bin_path, "-name", f"guest={vm_name}"]
                
                # Add additional configuration if provided
                if vm_config:
                    for key, value in vm_config.items():
                        if isinstance(value, bool) and value:
                            cmd.append(f"-{key}")
                        else:
                            cmd.extend([f"-{key}", str(value)])
                
                # Start QEMU process in the background
                process = self._run_command(cmd)
                if not process:
                    return False
                
                # Give it a moment to start
                time.sleep(2)
                
                # Check if it's running
                return self.get_vm_status(vm_name, uri)['status'] == 'Running'
                
            except Exception as e:
                log.error(f"Error starting direct QEMU VM {vm_name}: {e}")
                return False
        
        log.error(f"Invalid URI provided for VM {vm_name}")
        return False
    
    def stop_vm(self, vm_name, uri, force=False, timeout=3):
        """
        Stop a running VM (either direct QEMU or libvirt-managed).
        
        Args:
            vm_name (str): Name of the VM to stop.
            uri (str): URI identifier - 'qemu' for direct QEMU VMs or libvirt URI.
            force (bool): If True, forcefully kill the VM. If False, attempt graceful shutdown.
            timeout (int): Time in seconds to wait for graceful shutdown before forcing.
            
        Returns:
            bool: True if VM was stopped successfully, False otherwise.
        """
        # Check current status
        status_info = self.get_vm_status(vm_name, uri)
        
        # If already stopped, nothing to do
        if status_info['status'] == 'Stopped':
            log.info(f"VM {vm_name} is already stopped")
            return True
        
        log.info(f"Stopping VM {vm_name} with status: {status_info}")
        
        # Handle libvirt VMs
        if uri != 'qemu' and status_info['type'] == 'libvirt':
            try:
                if force:
                    cmd = ["virsh", "-c", uri, "destroy", vm_name]
                else:
                    cmd = ["virsh", "-c", uri, "shutdown", vm_name]
                
                log.debug(f"Running command: {' '.join(cmd)}")
                process = self._run_command(cmd)
                if process:
                    stdout, stderr = process.communicate()
                    cmd_result = process.wait()
                    
                    if cmd_result != 0:
                        log.error(f"Failed to stop libvirt VM {vm_name}: {stderr.decode() if stderr else ''}")
                        return False
                    
                    # Wait for VM to stop if using graceful shutdown
                    if not force:
                        start_time = time.time()
                        while time.time() - start_time < timeout:
                            if self.get_vm_status(vm_name, uri)['status'] == 'Stopped':
                                return True
                            time.sleep(1)
                        
                        # If still running after timeout, force kill
                        if self.get_vm_status(vm_name, uri)['status'] == 'Running':
                            log.warning(f"Timeout waiting for graceful shutdown, forcing VM {vm_name} to stop")
                            log.debug("Forcing shutdown")
                            force_process = self._run_command(["virsh", "-c", uri, "destroy", vm_name])
                            if force_process:
                                force_process.communicate()
                    
                    time.sleep(0.2)  # Give it a moment
                    return self.get_vm_status(vm_name, uri)['status'] == 'Stopped'
                return False
            
            except Exception as e:
                log.error(f"Error stopping libvirt VM {vm_name}: {e}")
                return False
        
        # Handle direct QEMU VMs
        elif uri == 'qemu' and status_info['type'] == 'qemu':
            try:
                # Find the process ID
                process = self._run_command(["pgrep", "-f", f"qemu.*{vm_name}"])
                if process:
                    stdout, _ = process.communicate()
                    result = process.wait()
                    
                    if result != 0:
                        return True  # Already stopped
                    
                    pid = int(stdout.decode().strip())
                    
                    if force:
                        # Force kill
                        os.kill(pid, signal.SIGKILL)
                    else:
                        # Try graceful shutdown first (SIGTERM)
                        os.kill(pid, signal.SIGTERM)
                        
                        # Wait for VM to stop
                        start_time = time.time()
                        while time.time() - start_time < timeout:
                            if self.get_vm_status(vm_name, uri)['status'] == 'Stopped':
                                return True
                            time.sleep(1)
                        
                        # If still running after timeout, force kill
                        if self.get_vm_status(vm_name, uri)['status'] == 'Running':
                            log.warning(f"Timeout waiting for graceful shutdown, forcing VM {vm_name} to stop")
                            os.kill(pid, signal.SIGKILL)
                    
                    # Give it a moment
                    time.sleep(1)
                    
                    # Check if it's stopped
                    return self.get_vm_status(vm_name, uri)['status'] == 'Stopped'
                return False
                
            except Exception as e:
                log.error(f"Error stopping direct QEMU VM {vm_name}: {e}")
                return False
        
        # VM not found or URI and type don't match
        else:
            log.error(f"VM {vm_name} not found or URI type ({uri}) doesn't match VM type ({status_info['type']})")
            return False

# Test code
if __name__ == "__main__":
    qemu_controller = QEMUController()
    
    # Get the default URI
    print(f"Default libvirt URI: {qemu_controller.default_uri}")
    
    # Get VMs from all connections
    vms = qemu_controller.get_vms(show_all_connections=True)
    
    # Print QEMU VMs
    print("\\nQEMU VMs:", vms['qemu'])
    
    # Print libvirt VMs by connection
    print("\\nLibvirt VMs by connection:")
    for uri, vm_list in vms['libvirt'].items():
        print(f"  URI: {uri}")
        print(f"    VMs: {vm_list}")

    qemu_controller.stop_vm("Fedora39", "qemu:///system")