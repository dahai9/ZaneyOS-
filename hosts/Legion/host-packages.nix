{
  pkgs,
  unstable-pkgs,
  ...
}: let
in {
  environment.systemPackages =
    (with pkgs; [
      # audacity
      # discord
      kdePackages.okular
      nodejs
      mission-center
      termius
      gparted
      rclone
      #file manager
      nautilus
      # develop
      openssl # required by openssl-sys a rust crate
      openssl.dev # required by openssl-sys a rust crate
      direnv
      nix-direnv
      gcc
      uv
      inetutils # for telnet
      minicom
      wpsoffice-cn
      mold
      gh
      icu
      telegram-desktop
      cc-switch
    ])
    ++ (with unstable-pkgs; [
      vscode
      qq
      wechat
      # rust toolchain
      rustup
      firefox
      google-chrome
    ]);
}
