self: super: {
  windsurf = super.callPackage ./package.nix {
    vscode-generic = ./vscode-generic.nix;
  };
}
