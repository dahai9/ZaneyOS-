{
  host,
  pkgs,
  ...
}:
let
  vars = import ../../hosts/${host}/variables.nix;
  consoleKeyMap = vars.consoleKeyMap or "us";
  timeZone = vars.timeZone or "America/New_York";
in
{
  nix = {
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };
  time.timeZone = "${timeZone}";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk # alternatively,
      kdePackages.fcitx5-qt
      qt6Packages.fcitx5-chinese-addons # table input method support
      fcitx5-nord # a color theme
      fcitx5-rime
    ];
  };
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    ZANEYOS_VERSION = "2.5.5";
    ZANEYOS = "true";
    PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
  };
  # to your system configuration to get completion for system packages (e.g. systemd).
  environment.pathsToLink = [ "/share/zsh" ];
  console.keyMap = "${consoleKeyMap}";
  system.stateVersion = "25.11"; # Do not change!
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages   QYKw9umtV2HVDDZ5qnF8DuSxcuvR
    openssl
    curl
    zlib
    libssh2
    nghttp2
    pkg-config
    libGL
    glib

  ];

}
