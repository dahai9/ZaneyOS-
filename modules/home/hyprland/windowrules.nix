{
  host,
  lib,
  ...
}: let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    extraMonitorSettings
    ;
  mkRule = action: matchers: "${action}, ${lib.concatStringsSep ", " matchers}";
  byClass = regex: "match:class ${regex}";
  byTitle = regex: "match:title ${regex}";
  byInitialTitle = regex: "match:initial_title ${regex}";
  byTag = tag: "match:tag ${tag}";
  byFullscreen = enabled: "match:fullscreen ${
    if enabled
    then "1"
    else "0"
  }";
  byXwayland = enabled: "match:xwayland ${
    if enabled
    then "1"
    else "0"
  }";
in {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        #"noblur, xwayland:1" # Helps prevent odd borders/shadows for xwayland apps
        # downside it can impact other xwayland apps
        # This rule is a template for a more targeted approach
        (mkRule "no_blur on" [
          (byClass "^resolve$")
          (byXwayland true)
        ]) # Window rule for just resolve
        (mkRule "tag +file-manager" [(byClass "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$")])
        (mkRule "tag +terminal" [(byClass "^(com.mitchellh.ghostty|org.wezfurlong.wezterm|Alacritty|kitty|kitty-dropterm)$")])
        (mkRule "tag +browser" [(byClass "^(Brave-browser(-beta|-dev|-unstable)?)$")])
        (mkRule "tag +browser" [(byClass "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$")])
        (mkRule "tag +browser" [(byClass "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$")])
        (mkRule "tag +browser" [(byClass "^([Tt]horium-browser|[Cc]achy-browser)$")])
        (mkRule "tag +projects" [(byClass "^(codium|codium-url-handler|VSCodium)$")])
        (mkRule "tag +projects" [(byClass "^(VSCode|code-url-handler)$")])
        (mkRule "tag +im" [(byClass "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$")])
        (mkRule "tag +im" [(byClass "^([Ff]erdium)$")])
        (mkRule "tag +im" [(byClass "^([Ww]hatsapp-for-linux)$")])
        (mkRule "tag +im" [(byClass "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$")])
        (mkRule "tag +im" [(byClass "^(teams-for-linux)$")])
        (mkRule "tag +games" [(byClass "^(gamescope)$")])
        (mkRule "tag +games" [(byClass "^(steam_app_[0-9]+)$")])
        (mkRule "tag +gamestore" [(byClass "^([Ss]team)$")])
        (mkRule "tag +gamestore" [(byTitle "^([Ll]utris)$")])
        (mkRule "tag +gamestore" [(byClass "^(com.heroicgameslauncher.hgl)$")])
        (mkRule "tag +settings" [(byClass "^(gnome-disks|wihotspot(-gui)?)$")])
        (mkRule "tag +settings" [(byClass "^([Rr]ofi)$")])
        (mkRule "tag +settings" [(byClass "^(file-roller|org.gnome.FileRoller)$")])
        (mkRule "tag +settings" [(byClass "^(nm-applet|nm-connection-editor|blueman-manager)$")])
        (mkRule "tag +settings" [(byClass "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$")])
        (mkRule "tag +settings" [(byClass "^(nwg-look|qt5ct|qt6ct|[Yy]ad)$")])
        (mkRule "tag +settings" [(byClass "^(xdg-desktop-portal-gtk)$")])
        (mkRule "tag +settings" [(byClass "^.blueman-manager-wrapped$")])
        (mkRule "tag +settings" [(byClass "^(nwg-displays)$")])
        (mkRule "move 72% 7%" [(byTitle "^(Picture-in-Picture)$")])
        # qs-keybinds floating viewer
        (mkRule "float on" [(byTitle "^(Hyprland Keybinds|Emacs Leader Keybinds|Kitty Configuration|WezTerm Configuration|Ghostty Configuration|Yazi Configuration)$")])
        (mkRule "center on" [(byTitle "^(Hyprland Keybinds|Emacs Leader Keybinds|Kitty Configuration|WezTerm Configuration|Ghostty Configuration|Yazi Configuration)$")])
        (mkRule "size 55% 66%" [(byTitle "^(Hyprland Keybinds|Emacs Leader Keybinds|Kitty Configuration|WezTerm Configuration|Ghostty Configuration|Yazi Configuration)$")])
        # qs-cheatsheets floating viewer
        (mkRule "float on" [(byTitle "^(Cheatsheets Viewer)$")])
        (mkRule "center on" [(byTitle "^(Cheatsheets Viewer)$")])
        (mkRule "size 65% 60%" [(byTitle "^(Cheatsheets Viewer)$")])
        (mkRule "center on" [(byClass "^([Ff]erdium)$")])
        (mkRule "float on" [(byClass "^([Ww]aypaper)$")])
        (mkRule "center on" [(byClass "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$")])
        (mkRule "center on" [
          (byClass "([Tt]hunar)")
          (byTitle "negative:(.*[Tt]hunar.*)")
        ])
        (mkRule "center on" [(byTitle "^(Authentication Required)$")])
        (mkRule "idle_inhibit fullscreen" [(byClass "^.*$")])
        (mkRule "idle_inhibit fullscreen" [(byTitle "^.*$")])
        (mkRule "idle_inhibit fullscreen" [(byFullscreen true)])
        (mkRule "float on" [(byTag "settings*")])
        (mkRule "float on" [(byClass "^([Ff]erdium)$")])
        (mkRule "float on" [(byTitle "^(Picture-in-Picture)$")])
        (mkRule "float on" [(byClass "^(mpv|com.github.rafostar.Clapper)$")])
        (mkRule "float on" [(byTitle "^(Authentication Required)$")])
        (mkRule "float on" [
          (byClass "(codium|codium-url-handler|VSCodium)")
          (byTitle "negative:(.*codium.*|.*VSCodium.*)")
        ])
        (mkRule "float on" [
          (byClass "^(com.heroicgameslauncher.hgl)$")
          (byTitle "negative:(Heroic Games Launcher)")
        ])
        (mkRule "float on" [
          (byClass "^([Ss]team)$")
          (byTitle "negative:^([Ss]team)$")
        ])
        (mkRule "float on" [
          (byClass "([Tt]hunar)")
          (byTitle "negative:(.*[Tt]hunar.*)")
        ])
        (mkRule "float on" [(byInitialTitle "^(Add Folder to Workspace)$")])
        (mkRule "float on" [(byInitialTitle "^(Open Files)$")])
        (mkRule "float on" [(byInitialTitle "^(wants to save)$")])
        (mkRule "size 70% 60%" [(byInitialTitle "^(Open Files)$")])
        (mkRule "size 70% 60%" [(byInitialTitle "^(Add Folder to Workspace)$")])
        (mkRule "size 70% 70%" [(byTag "settings*")])
        (mkRule "size 60% 70%" [(byClass "^([Ff]erdium)$")])
        (mkRule "opacity 1.0 1.0" [(byTag "browser*")])
        (mkRule "opacity 0.9 0.8" [(byTag "projects*")])
        (mkRule "opacity 0.94 0.86" [(byTag "im*")])
        (mkRule "opacity 0.9 0.8" [(byTag "file-manager*")])
        (mkRule "opacity 0.8 0.7" [(byTag "terminal*")])
        (mkRule "opacity 0.8 0.7" [(byTag "settings*")])
        (mkRule "opacity 0.8 0.7" [(byClass "^(gedit|org.gnome.TextEditor|mousepad)$")])
        (mkRule "opacity 0.9 0.8" [(byClass "^(seahorse)$")]) # gnome-keyring gui
        (mkRule "opacity 0.95 0.75" [(byTitle "^(Picture-in-Picture)$")])
        (mkRule "pin on" [(byTitle "^(Picture-in-Picture)$")])
        (mkRule "keep_aspect_ratio on" [(byTitle "^(Picture-in-Picture)$")])
        (mkRule "no_blur on" [(byTag "games*")])
        (mkRule "fullscreen on" [(byTag "games*")])
      ];
    };
  };
}
