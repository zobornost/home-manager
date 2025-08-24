{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:nix-community/stylix";
    catppuccin.url = "github:catppuccin/nix";
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      catppuccin,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ./overlays/kiro/kiro.nix)
          (import ./overlays/windsurf/windsurf.nix)
        ];
      };
    in
    {
      homeConfigurations."oz" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
      homeConfigurations."zoe" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
