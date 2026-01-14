{ pkgs, ... }:
{
  systemd.services."reload-mt7921e" = {
    description = "Reload mt7921e after suspend";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe -r mt7921e";
      ExecStartPost = "${pkgs.kmod}/bin/modprobe mt7921e";
    };
  };
  systemd.targets."sleep".wantedBy = [ "reload-mt7921e.service" ];

}
