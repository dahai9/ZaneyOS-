{ pkgs, unstable-pkgs, ... }:
{
  environment.systemPackages =
    (with pkgs; [
      # audacity
      # discord
      kdePackages.okular
      nodejs
      firefox
      mission-center
      termius
      gparted
      telegram-desktop
      rclone
      inetutils # for telnet
    ])
    ++ (with unstable-pkgs; [
      vscode
      qq
      wechat
      # rust toolchain
      rustup
    ]);

}
