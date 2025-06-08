while true; do
  battery_level=$(acpi -b | awk '/^Battery 0/ {print $4}')
  battery_level=${battery_level//[%,]}

  discharging=$(acpi -b | awk '/^Battery 0: Discharging/ {print $3}')

  if [ "$battery_level" -lt 20 ] && [ -n "$discharging" ]; then
    notify-send "Battery Warning" "Battery level is below 20%"
  fi
  sleep 1
done
