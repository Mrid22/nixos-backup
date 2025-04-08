{ pkgs }:

pkgs.writeShellScriptBin "reload" ''
    echo "Syncing with git"
    ${pkgs.git}/bin/git pull
    PATH = /etc/nixos/nixos-backup/.
    read -p 'Commit Message: ' commitmsg
    ${pkgs.git}/bin/git -C $PATH add .
    ${pkgs.git}/bin/git -C $PATH commit -m "$commitmsg"
    ${pkgs.git}/bin/git -C $PATH push
    sudo nixos-rebuild switch --flake $PATH
''
