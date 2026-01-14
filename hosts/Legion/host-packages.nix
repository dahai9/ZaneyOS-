{ pkgs, unstable-pkgs, ... }:
{
  environment.systemPackages =
    (with pkgs; [
      # audacity
      # discord
      kdePackages.okular
      nodejs
      # firefox
      mission-center
      termius
      gparted
      telegram-desktop
      rclone
      #file manager
      nautilus
      # develop
      gcc
      uv
      inetutils # for telnet
      minicom
      wpsoffice-cn
    ])
    ++ (with unstable-pkgs; [
      vscode
      qq
      wechat
      # rust toolchain
      rustup
    ]);

}
