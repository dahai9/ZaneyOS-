{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/release-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Checking nixvim to see if it's better
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Google Antigravity (IDE)
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      nix-flatpak,
      alejandra,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      host = "Legion";
      profile = "amd-hybrid";
      username = "dahai003";
      unstable-pkgs = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      # Deduplicate nixosConfigurations while preserving the top-level 'profile'
      mkNixosConfig =
        gpuProfile:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile; # keep using the let-bound profile for modules/scripts
            inherit unstable-pkgs;
          };
          modules = [
            ./modules/core/overlays.nix
            ./profiles/${gpuProfile}
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };
    in
    {
      nixosConfigurations = {
        amd = mkNixosConfig "amd";
        nvidia = mkNixosConfig "nvidia";
        nvidia-laptop = mkNixosConfig "nvidia-laptop";
        amd-hybrid = mkNixosConfig "amd-hybrid";
        intel = mkNixosConfig "intel";
        vm = mkNixosConfig "vm";
      };

      formatter.x86_64-linux = inputs.alejandra.packages.x86_64-linux.default;
    };
}
