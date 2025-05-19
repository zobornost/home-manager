{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:danth/stylix";
  };
  outputs = inputs @ { nixpkgs, home-manager, catppuccin, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."oz" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./ssh.nix
          ./vim.nix
          ./windsurf.nix
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
