{ pkgs, host,... }:
let
  vars = import ../../hosts/${host}/variables.nix;
  inherit (vars)
    alacrittyEnable
    barChoice
    ghosttyEnable
    tmuxEnable
    waybarChoice
    weztermEnable
    vscodeEnable
    helixEnable
    doomEmacsEnable
    antigravityEnable
    browser
    ;
in
{
  xdg = {
    enable = true;
    portal = {
      enable = true;
      # wlr.enable = true;
      extraPortals = [
        # pkgs.xdg-desktop-portal
        # pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-hyprland
      ];

      configPackages = [
        # pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal-wlr
        pkgs.hyprland
        # pkgs.niri
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # —— 浏览器 / URL ——
      "x-scheme-handler/http" = [ "${browser}.desktop" ];
      "x-scheme-handler/https" = [ "${browser}.desktop" ];
      "text/html" = [ "${browser}.desktop" ];

      # —— 文本 & 代码 ——（把 nvim.desktop 换成 code.desktop 可用 VS Code）
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "application/x-shellscript" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      "application/xml" = [ "nvim.desktop" ];
      "text/x-python" = [ "nvim.desktop" ];
      "text/x-c" = [ "nvim.desktop" ];
      "text/x-c++src" = [ "nvim.desktop" ];
      "text/x-go" = [ "nvim.desktop" ];
      "text/x-rustsrc" = [ "nvim.desktop" ];
      "text/x-makefile" = [ "nvim.desktop" ];
      "text/x-toml" = [ "nvim.desktop" ];
      "text/x-ini" = [ "nvim.desktop" ];
      "text/x-log" = [ "nvim.desktop" ];
      "application/x-yaml" = [ "nvim.desktop" ];
      "text/x-nix" = [ "nvim.desktop" ];

      # —— PDF ——
      "application/pdf" = [ "org.kde.okular.desktop" ];

      # —— 图片 ——
      "image/png" = [ "org.gnome.eog.desktop" ]; # 或 "org.gnome.eog.desktop" / "sxiv.desktop"
      "image/jpeg" = [ "org.gnome.eog.desktop" ];
      "image/webp" = [ "org.gnome.eog.desktop" ];
      "image/gif" = [ "org.gnome.eog.desktop" ];
      "image/svg+xml" = [ "org.gnome.eog.desktop" ];

      # —— 视频 ——
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/ogg" = [ "mpv.desktop" ];

      # —— 音频 ——
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];

      # —— 压缩包 ——
      "application/zip" = [ "org.gnome.FileRoller.desktop" ]; # 或 "xarchiver.desktop"
      "application/x-tar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];

      # —— 终端（链接或 .desktop 调用）——
      "x-scheme-handler/terminal" = [ "kitty.desktop" ]; # 或 "alacritty.desktop" / "kitty.desktop"
    };

    # 可选：把多个可选项加入“打开方式”列表
  };
}
