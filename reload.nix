{ pkgs }:

pkgs.writeShellScriptBin "reload" ''
    path=/etc/nixos/nixos-backup/.
    echo "Syncing with git"
    ${pkgs.git}/bin/git -C $path pull
    read -p 'Commit Message: ' commitmsg
    ${pkgs.git}/bin/git -C $path add .
    ${pkgs.git}/bin/git -C $path commit -m "$commitmsg"
    ${pkgs.git}/bin/git -C $path push
    sudo nixos-rebuild switch --flake $path
''
