{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # audacity
    # discord
    kdePackages.okular
    nodejs
    firefox
    mission-center
    termius
    gparted
  ];
}
