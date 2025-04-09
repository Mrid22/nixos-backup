{ pkgs }:

pkgs.writeShellScriptBin "update" ''
    path=/etc/nixos/nixos-backup/.
    echo "Syncing with git"
    ${pkgs.git}/bin/git -C $path pull
    commitmsg = "system update"
    ${pkgs.git}/bin/git -C $path add .
    ${pkgs.git}/bin/git -C $path commit -m "$commitmsg"
    ${pkgs.git}/bin/git -C $path push
    nix flake update
    sudo nixos-rebuild switch --flake $path
''
