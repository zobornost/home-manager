{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    catppuccin.url = "github:catppuccin/nix";
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      catppuccin,
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
          ./oz.nix
          catppuccin.homeModules.catppuccin
        ];
        extraSpecialArgs = { inherit inputs; };
      };
      homeConfigurations."zoe" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./zoe.nix
          catppuccin.homeModules.catppuccin
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
