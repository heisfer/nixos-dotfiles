{pkgs, config, inputs, self, ...}:
{
  home.stateVersion = "22.11";
  home.packages = with pkgs; [ 
    firefox-devedition-bin
    discord
    grim
    neofetch
    slurp
    jq
    imagemagick
    youtube-music
    scrcpy
    symfony-cli
    jetbrains.phpstorm
    nix-prefetch-git
    lm_sensors
    pavucontrol
    htop
    xorg.xeyes
    wl-clipboard
    libnotify
    zip
    unzip
    (callPackage ./pkgs/den.nix { } )
    (callPackage ./pkgs/gdlauncher.nix { } )
    (callPackage ./pkgs/miru.nix { } )
  ];
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./dot/hyprland.conf;
  };

  programs.rofi = {
    enable = true;
    font = "Comic Code Ligatures 14";
    package = pkgs.rofi-wayland.override {
    plugins = with pkgs; [ rofi-rbw ];
    };
  };
  
  xdg.configFile."rofi".source = ./dot/rofi;
  programs.wezterm  = {
    enable = true;
    extraConfig = builtins.readFile ./dot/wezterm/wezterm.lua;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
  };
  services.dunst = {
    enable = true;
  };
  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
