{
  inputs,
  profile,
  ...
}: {
  nixpkgs.overlays = [
    # Provide pkgs.google-antigravity via antigravity-nix overlay
    inputs.antigravity-nix.overlays.default
    (final: prev: let
      REAL = "${prev.brightnessctl}/bin/brightnessctl";
      wrapped = final.writeShellScriptBin "brightnessctl" ''
        #!/bin/sh
        set -eu
        REAL="${REAL}"
        for arg in "$@"; do
          case "$arg" in
            -d|--device|--device=*)
              exec "$REAL" "$@"
              ;;
          esac
        done
        for dev in amdgpu_bl2 amdgpu_bl1 amdgpu_bl0; do
          if [ -e "/sys/class/backlight/$dev" ]; then
            exec "$REAL" -d "$dev" "$@"
          fi
        done
        exec "$REAL" "$@"
      '';
    in {
      brightnessctl =
        if profile == "amd-hybrid"
        then wrapped
        else prev.brightnessctl;
    })

    (final: prev: {
      # 注意：这里覆盖的是“你要安装的 noctalia-shell 包”，
      # 把它改成使用 final.brightnessctl（已 overlay）
      noctalia-shell = inputs.noctalia.packages.${final.stdenv.hostPlatform.system}.default.override {
        brightnessctl = final.brightnessctl;
      };
    })
  ];
}
