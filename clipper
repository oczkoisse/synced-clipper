#!/usr/bin/env bash

function print_usage
{
    echo "Overlays video2 onto video1 as an inset. Optionally, user can clip portions of the overlayed video using ; and '"
    echo "Usage: clipper <path_to_video1> <path_to_video2>"
}

if [ -z "$1" -o -z "$2" -o ! -f "$1" -o ! -f "$2" ]; then
    print_usage
else
    fname=$(basename "$1")
    fname=${fname%.*}
    mpv --script="./mark.lua" --lavfi-complex="[vid2]scale=iw/3:ih/3 [pip]; [vid1][pip] overlay=main_w-overlay_w-10:10 [vo]; [aid1][aid2]amix[ao]" "$1" --external-file="$2"
    while IFS=',' read start_ts stop_ts
    do
        ffmpeg -y -i "$1" -i "$2" -filter_complex "[0:v] trim=${start_ts}:${stop_ts}, setpts=PTS-STARTPTS, scale=iw/2:ih/2 [clip1]; [1:v] trim=${start_ts}:${stop_ts}, setpts=PTS-STARTPTS, scale=iw/2:ih/2 [clip2]; [clip1][clip2] hstack [vout]" -map "[vout]" "${fname}_${start_ts%.*}_${stop_ts%.*}.avi" </dev/null
    done<endpoints.txt
    rm endpoints.txt
fi
