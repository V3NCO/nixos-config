import sys
import unittest
from pathlib import Path
from unittest.mock import patch, Mock

absolute_mock_path = str(Path(__file__).parent / "stream_controller_mock")
sys.path.insert(0, absolute_mock_path)

absolute_plugin_path = str(Path(__file__).parent.parent.parent.absolute())
sys.path.insert(0, absolute_plugin_path)

from HomeAssistantPlugin import const
from HomeAssistantPlugin.main import HomeAssistant


class TestMainSetStatus(unittest.TestCase):

    @patch.object(HomeAssistant, "add_action_holder")
    @patch.object(HomeAssistant, "register")
    @patch("HomeAssistantPlugin.main.PerformAction")
    @patch("HomeAssistantPlugin.main.ActionHolder")
    @patch("HomeAssistantPlugin.main.HomeAssistantBackend")
    @patch("HomeAssistantPlugin.main.ConnectionSettings")
    @patch("HomeAssistantPlugin.main.GLib")
    def test_set_status(self, glib_mock, _, __, ___, ____, _____, ______):
        idle_add_mock = Mock()

        glib_mock.idle_add = idle_add_mock

        set_text_mock = Mock()

        connection_status_mock = Mock()
        connection_status_mock.set_text = set_text_mock

        instance = HomeAssistant()
        instance.connection_status = connection_status_mock
        instance.set_status(const.HOME_ASSISTANT)

        idle_add_mock.assert_called_once_with(set_text_mock, const.HOME_ASSISTANT)

