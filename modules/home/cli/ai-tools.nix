{
  host,
  pkgs,
  unstable-pkgs,
  ...
}: let
  vars = import ../../../hosts/${host}/variables.nix;
  codexEnable = vars.codexEnable or false;
  geminiCliEnable = vars.geminiCliEnable or false;
  opencodeEnable = vars.opencodeEnable or false;
in {
  home.packages =
    (
      if codexEnable
      then [pkgs.codex]
      else []
    )
    ++ (
      if geminiCliEnable
      then [unstable-pkgs.gemini-cli-bin]
      else []
    )
    ++ (
      if opencodeEnable
      then [unstable-pkgs.opencode]
      else []
    );
}
