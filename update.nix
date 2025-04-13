{pkgs}:
pkgs.writeShellScriptBin "update" ''
  path=/etc/nixos/nixos-backup/.
  echo "Syncing with git"
  ${pkgs.git}/bin/git -C $path pull
  commitmsg = "system update"
  ${pkgs.git}/bin/git -C $path add .
  ${pkgs.git}/bin/git -C $path commit -m "$commitmsg"
  nix flake update
  sudo nixos-rebuild switch --flake $path
  ${pkgs.git}/bin/git -C $path push
''
