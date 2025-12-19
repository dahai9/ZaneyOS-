{ pkgs, ... }:
{
  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "spaceship";
        customPkgs = [
          pkgs.spaceship-prompt
        ];
      };

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
        # fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
        #set spaceship ,the sysmbol is nix logo need jetbrain font 
        SPACESHIP_ASYNC_SYMBOL="󱄅"
        SPACESHIP_DIR_TRUNC=0
        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # Set-up icons for files/folders in terminal using lsd
        # alias ls='lsd'
        # alias l='ls -l'
        # alias la='ls -a'
        # alias lla='ls -la'
        # alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
        # export PKG_CONFIG_PATH=/run/current-system/sw/lib/pkgconfig
        export NODE_EXTRA_CA_CERTS=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
        if [ -d "/run/opengl-driver/lib" ]; then
          export NVIDIA_DRIVERS="/run/opengl-driver/lib"
        else
          echo "WARNING: /run/opengl-driver/lib not found! The project is unlikely to run on NixOS"
        fi
        export CUDA_HOME="${pkgs.cudaPackages.cudatoolkit}"
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NVIDIA_DRIVERS:${pkgs.cudatoolkit}"
        export EXTRA_LDFLAGS="-L/lib -L$NVIDIA_DRIVERS"
        # export OPENSSL_DIR=${pkgs.openssl.dev}
      '';
    };
  };
  environment.shells = [
    pkgs.zsh
  ];
}
