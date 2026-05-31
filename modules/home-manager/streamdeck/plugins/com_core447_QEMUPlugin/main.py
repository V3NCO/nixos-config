# Import StreamController modules
from src.backend.PluginManager.PluginBase import PluginBase
from src.backend.PluginManager.ActionHolder import ActionHolder

# Import actions
from .actions.ToggleState.ToggleState import ToggleState

class PluginTemplate(PluginBase):
    def __init__(self):
        super().__init__()

        ## Register actions
        self.simple_action_holder = ActionHolder(
            plugin_base = self,
            action_base = ToggleState,
            action_id = "dev_core447_Template::ToggleState", # Change this to your own plugin id
            action_name = "Toggle State",
        )
        self.add_action_holder(self.simple_action_holder)

        # Register plugin
        self.register(
            plugin_name = "QEMU",
            github_repo = "https://github.com/StreamController/QEMUPlugin",
            plugin_version = "1.0.0",
            app_version = "1.5.0-beta.8"
        )