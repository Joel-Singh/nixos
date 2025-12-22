{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      hp = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/hp/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/thinkpad/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      thinkpad-new = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/thinkpad-new/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
