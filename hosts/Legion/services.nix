{ pkgs, ... }:
{
  # systemd.services."reload-mt7921e" = {
  #   description = "Reload mt7921e after suspend";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.kmod}/bin/modprobe -r mt7921e";
  #     ExecStartPost = "${pkgs.kmod}/bin/modprobe mt7921e";
  #   };
  # };

  systemd.services."reload-rndis" = {
    description = "Reload rndis_host after suspend/hibernate";
    after = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe -r rndis_host";
      ExecStartPost = "${pkgs.kmod}/bin/modprobe rndis_host";
    };
  };
}
