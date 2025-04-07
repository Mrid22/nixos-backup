{ pkgs }:

pkgs.writeShellScriptBin "reload" ''
    echo "Syncing with git"
    read -p 'Commit Message: ' commitmsg
    ${pkgs.git}/bin/git add .
    ${pkgs.git}/bin/git commit -m $commitmsg
    ${pkgs.git}/bin/git push
    sudo nixos-rebuild switch --flake /etc/nixos/nixos-backup/.
''
