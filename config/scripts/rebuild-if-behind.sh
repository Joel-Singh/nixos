set -e
sleep 3 # Wait for internet

cd /home/apple/repos/nixos/

git fetch
git pull
sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER
