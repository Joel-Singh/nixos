set -e
sleep 3 # Wait for internet

cd /home/apple/repos/nixos/

git pull
notify-send "am rebuilding"
notify-send $CURRENT_COMPUTER
sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER
notify-send "finished rebuilding"
