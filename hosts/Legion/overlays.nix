{
  profile,
  nixpkgs,
  ...
}: {
  nixpkgs.overlays = [
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
    }) ## inoder to override brightnessctl only for amd-hybrid profile
  ];
}
