{pkgs}:
pkgs.writeShellScriptBin "update" ''
  path=/etc/nixos/nixos-backup/.
  nix flake update
  ${pkgs.git}/bin/git -C $path add .
  ${pkgs.git}/bin/git -C $path commit -m "update"
  ${pkgs.git}/bin/git -C $path push
  sudo nixos-rebuild switch --recreate-lock-file --flake $path

''
