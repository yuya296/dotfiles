{
  description = "yuya's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      mkHome = { system, module }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./nix/home/common.nix module ];
        };
    in {
      homeConfigurations = {
        darwin = mkHome {
          system = "aarch64-darwin";
          module = ./nix/home/darwin.nix;
        };
        ubuntu = mkHome {
          system = "aarch64-linux";
          module = ./nix/home/linux-ubuntu.nix;
        };
      };
    };
}
