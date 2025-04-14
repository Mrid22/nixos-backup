{pkgs}:
pkgs.writeShellScriptBin "update" ''
  path=/etc/nixos/nixos-backup/.
  echo "Syncing with git"
  ${pkgs.git}/bin/git -C $path pull
  ${pkgs.git}/bin/git -C $path add .
  ${pkgs.git}/bin/git -C $path commit -m "update"
  ${pkgs.git}/bin/git -C $path push
  sudo nixos-rebuild switch --flake $path
''
