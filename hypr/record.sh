#!/bin/bash
if pgrep -x "gpu-screen-recor" > /dev/null; then
    pkill -SIGINT -x gpu-screen-recor
    notify-send -t 2000 "GPU Recorder" "Запись сохранена"
else
    notify-send -t 2000 "GPU Recorder" "Запись началась"
    gpu-screen-recorder -w HDMI-A-1 -f 60 -a alsa_output.pci-0000_14_00.6.analog-stereo.monitor -o /home/lenique/Videos/rec_$(date +%H-%M-%S).mp4
fi
