{ config, lib, ... }:
let
  pathtokeys = ../../system/users/keys;
  yubikeys = lib.lists.forEach (builtins.attrNames (builtins.readDir pathtokeys))
    (key: lib.substring 0 (lib.stringLength key - lib.stringLength ".pub") key);
  yubikeyPublicKeyEntries = lib.attrsets.mergeAttrsList (
    lib.lists.map
      (key: { ".ssh/${key}.pub".source = "${pathtokeys}/${key}.pub"; })
      yubikeys
  );
in
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';
  };
  home.file = {
    ".ssh/sockets/.keep".text = "# Managed by Home Manager";
  } // yubikeyPublicKeyEntries;
}
