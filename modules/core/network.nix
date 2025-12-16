{
  pkgs,
  host,
  options,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in
{
  networking = {
    hostName = "${host}";
    hostId = hostId;
    nameservers = [
      "223.5.5.5"
      "8.8.8.8"
    ];
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
      trustedInterfaces = [ "Meta" ];
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
