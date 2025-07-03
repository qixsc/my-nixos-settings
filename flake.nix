{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }@inputs:

  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager{
          home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
          home-manager.users.qixsc = import ./home.nix;
        }
      ];
    };

    # "qixsc@nixos" = home-manager.lib.homeManagerConfiguration {
    #   inherit pkgs;
    #   modulus = [
    #     ./home.nix
    #   ];
    # };
  };
}
