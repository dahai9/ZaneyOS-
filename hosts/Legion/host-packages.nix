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
    ])
    ++ (with unstable-pkgs; [
      vscode
    ]);
  environment.shells = [
    pkgs.bash
    pkgs.zsh
  ];
}
