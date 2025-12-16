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
    ])
    ++ (with unstable-pkgs; [
      vscode
      qq
      wechat
    ]);
  environment.shells = [
    pkgs.bash
    pkgs.zsh
  ];
}
