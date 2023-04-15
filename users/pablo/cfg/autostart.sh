 xrandr --output HDMI-0 --mode 1920x1080 --rate 144 &

# Kill the process for "rsblocks"
pkill rsblocks

# Wait for 5 seconds
sleep 5

# Start the process for "rsblocks"
nohup rsblocks &


