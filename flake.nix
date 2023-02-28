
{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  {
    nixosConfigurations = {

      thinkchan = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {inherit inputs;};
              users.heisfer = {
                imports = [ ./home.nix ];
              };
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}

