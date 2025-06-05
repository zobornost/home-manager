{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:nix-community/stylix";
    catppuccin.url = "github:catppuccin/nix";
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
          catppuccin.homeModules.catppuccin
          stylix.homeModules.stylix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
