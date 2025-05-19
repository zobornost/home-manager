{ config, lib, ... }:
let
  pathtokeys = ./keys;
  yubikeys = lib.lists.forEach (builtins.attrNames (builtins.readDir pathtokeys)) (
    key: lib.substring 0 (lib.stringLength key - lib.stringLength ".pub") key
  );
  yubikeyPublicKeyEntries = lib.attrsets.mergeAttrsList (
    lib.lists.map (key: { ".ssh/${key}.pub".source = "${pathtokeys}/${key}.pub"; }) yubikeys
  );
in
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      SetEnv TERM=xterm-256color
      AddKeysToAgent yes
      Host *
        IdentityAgent ~/.1password/agent.sock
      Host nixosvm
        HostName 192.168.122.40
        User oz
    '';
  };
  home.file = {
    ".ssh/sockets/.keep".text = "# Managed by Home Manager";
  } // yubikeyPublicKeyEntries;
}
