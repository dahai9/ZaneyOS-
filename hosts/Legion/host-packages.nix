{
  pkgs,
  unstable-pkgs,
  ...
}: let
  # On AMD+NVIDIA hybrid, Qt's EGL picks up NVIDIA's driver which lacks
  # EGL_WL_bind_wayland_display, causing Telegram to segfault on Wayland.
  # Wrap Telegram to force Mesa EGL on the AMD iGPU.
  telegram-desktop-wrapped = pkgs.writeShellScriptBin "Telegram" ''
    export __GLX_VENDOR_LIBRARY_NAME=mesa
    export LIBGL_ALWAYS_SOFTWARE=0
    export MESA_LOADER_DRIVER_OVERRIDE=radeonsi
    export __NV_PRIME_RENDER_OFFLOAD=0
    export __VK_LAYER_NV_optimus=non_NVIDIA_only
    exec ${unstable-pkgs.telegram-desktop}/bin/telegram-desktop "$@"
  '';
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
    ])
    ++ (with unstable-pkgs; [
      vscode
      qq
      wechat
      # rust toolchain
      rustup
      firefox
      google-chrome
    ])
    ++ [
      telegram-desktop-wrapped
    ];
}
