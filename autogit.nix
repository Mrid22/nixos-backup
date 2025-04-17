{pkgs}:
pkgs.writeShellScriptBin "autogit" ''
  ${pkgs.git}/bin/git add .
  read -p 'Commit Message: ' commitmsg
  ${pkgs.git}/bin/git commit -m "$commitmsg"
  ${pkgs.git}/bin/git push
''
