{
  profile,
  pkgs,
  lib,
  username,
  ...
}:
{

  # Services to start
  services = {
    upower.enable = true; # noctalia shell battery
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    power-profiles-daemon.enable = true;
    openssh = {
      enable = false; # Enable SSH
      settings = {
        PermitRootLogin = "no"; # Prevent root from SSH login
        PasswordAuthentication = true; # Users can SSH using kb and password
        KbdInteractiveAuthentication = true;
      };
      ports = [ 22 ];
    };
    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;

    smartd = {
      enable = if profile == "vm" then false else true;
      autodetect = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
      };
    };

    resolved = {
      enable = true;
      dnssec = "false"; # for mihomo work properly
      #domains = [ "~." ];
      #fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
      dnsovertls = "false";
    };
    mihomo = {
      enable = true;
      configFile = "/home/${username}/.config/mihomo/config.yaml";
      tunMode = true;
      webui = pkgs.metacubexd;
    };
    usbmuxd.enable = true; # iPhone support
  };
  users.users.usbmux.extraGroups = [ "docker" ];
  systemd.services.mihomo = {
    wantedBy = lib.mkForce [ ]; # disable auto start
  };
  systemd.services.rclone-onedrive-mount = {
    description = "Service that connects to Google Drive";
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig =
      let
        riveDir = "/home/Onedrive"; # 你的Google Drive挂载目录
      in
      {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${riveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full Onedrive: ${riveDir} --vfs-cache-max-size 15G --allow-other";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${riveDir}";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        User = "dahai003";
      };
  };
  systemd.services.rclone-sync-mount = {
    description = "Service that connects to Google Drive";
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig =
      let
        riveDir = "/home/Sync"; # 你的Google Drive挂载目录
      in
      {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${riveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full Sync: ${riveDir} --vfs-cache-max-size 15G --allow-other";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${riveDir}";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
        User = "dahai003";
      };
  };
}
