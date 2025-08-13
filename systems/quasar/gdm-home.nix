{config, pkgs, inputs, ...}:
{
  home.username = "gdm";
  home.stateVersion = "25.05";


  home.file.".config/monitors.xml".text = ''
    <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <transform>
            <rotation>left</rotation>
            <flipped>no</flipped>
          </transform>
          <monitor>
            <monitorspec>
              <connector>DP-2</connector>
              <vendor>HPN</vendor>
              <product>HP E243</product>
              <serial>CNK0191078</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1080</height>
              <rate>60.000</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>1080</x>
          <y>523</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>HDMI-2</connector>
              <vendor>VSC</vendor>
              <product>VX2758 Series</product>
              <serial>VVG205330799</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1080</height>
              <rate>143.996</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <logicalmonitor>
          <x>3000</x>
          <y>523</y>
          <scale>1</scale>
          <monitor>
            <monitorspec>
              <connector>DP-1</connector>
              <vendor>HPN</vendor>
              <product>HP E243</product>
              <serial>CNK019106R</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1080</height>
              <rate>60.000</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
    '';
}
