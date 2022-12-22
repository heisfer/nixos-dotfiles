{pkgs, config, inputs, self, ...}:
{
  home.stateVersion = "22.11";
  home.packages = with pkgs; [ 
    firefox-devedition-bin
    discord
    grim
    wl-clipboard
    neofetch
    slurp
    jq
    imagemagick
    youtube-music
    scrcpy
    symfony-cli
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

}
