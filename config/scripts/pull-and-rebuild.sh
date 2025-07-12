set -e
sleep 10 # Wait for internet

cd /home/apple/repos/nixos/

git pull 
sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER
