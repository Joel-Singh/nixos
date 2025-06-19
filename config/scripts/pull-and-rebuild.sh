set -e
sleep 3 # Wait for internet

cd /home/apple/repos/nixos/

git pull
sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER
