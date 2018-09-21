#!/usr/bin/env bash
read signaler builder
mpv --script="./mark.lua" --lavfi-complex="[vid2]scale=iw/3:ih/3 [pip]; [vid1][pip] overlay=main_w-overlay_w-10:10 [vo]; [aid1][aid2]amix[ao]" "$signaler"--external-file="$builder"
