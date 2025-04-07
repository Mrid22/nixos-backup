echo "Syncing with git"
echo -n "Commit Message: "
read -r commit_message
git add .
git commit -m commit_message
git push
echo "reloading config"
sudo nixos-rebuild switch --flake /etc/nixos/nixos-backup/.
echo "Done"
