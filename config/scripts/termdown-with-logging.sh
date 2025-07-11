
mkdir -p /home/apple/stopwatch-times
termdown --exec-cmd "echo {0} > /home/apple/stopwatch-times/$(date +%s).txt"
