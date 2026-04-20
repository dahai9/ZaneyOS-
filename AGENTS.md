# Repository Guidelines

## Project Structure & Module Organization
`flake.nix` is the entry point and defines the active `host`, `profile`, and formatter. Put machine-specific settings in `hosts/<hostname>/` (`default.nix`, `variables.nix`, `hardware.nix`, `host-packages.nix`). Core system modules live in `modules/core/`, desktop and user-facing modules in `modules/home/`, GPU profiles in `profiles/`, and custom packages in `pkgs/`. Documentation, cheatsheets, and images are under `README*.md`, `cheatsheets/`, `img/`, and `wallpapers/`.

## Build, Test, and Development Commands
Run formatting before review:

```bash
alejandra .
shfmt -w install-zaneyos.sh modules/**/*.sh
```

Validate the flake and module graph with:

```bash
nix flake check
```

Do check-only builds for a profile with:

```bash
nix build .#nixosConfigurations.amd-hybrid.config.system.build.toplevel
```

Contributors and agents should prefer non-privileged validation commands; do not use `sudo` or apply system changes as part of routine checks.

## Coding Style & Naming Conventions
Keep Nix files formatted with `alejandra`; shell scripts should be `shfmt`-clean. Follow the existing style: small composable modules, one concern per file, and `default.nix` as the directory entry point. Use lowercase kebab-case for module and script filenames such as `modules/core/flatpak.nix` or `modules/src/upgrade-2.3-to-2.4.sh`. Preserve established names like `variables.nix`, `host-packages.nix`, and `hardware.nix` inside each host directory.

## Testing Guidelines
There is no dedicated `tests/` tree in this repository. Treat evaluation and build success as the primary regression check: run `nix flake check`, then `nix build .#nixosConfigurations.<profile>.config.system.build.toplevel` for the profile you changed. For host-specific edits, verify the matching `hosts/<hostname>/variables.nix` values still evaluate cleanly.

## Commit & Pull Request Guidelines
Recent history follows Conventional Commits, for example `feat: add direnv module` and `fix: mt7921e not up after suspend to sleep`. Use `feat:`, `fix:`, `docs:`, or `refactor:` prefixes and keep the subject line imperative. Pull requests should include a short summary, impacted hosts or profiles, manual validation steps, and screenshots for UI-facing changes such as Waybar, Hyprland, Niri, or Overview QML updates.
