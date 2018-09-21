# clipper

If you need to watch two videos simulaneously, so that you can extract clips of interesting parts from it, then this tool is for you. 

## Getting Started

Clone the repository to get a copy.

### Prerequisites

- **mpv** You can get a binary for your distro from the official [website](https://mpv.io/). Alternatively, you can also install it directly using your distro's package manager, if available
- **ffmpeg** Needed if you also want to extract clips instead of just writing the timestamps to a file.
```
# Arch
pacman -S mpv ffmpeg
# Ubuntu
apt-get install mpv ffmpeg
```

### Installing

Just clone the repository to get a copy.
```
git clone https://github.com/oczkoisse/clipper.git
```

### Usage
Start the clipper by providing the paths to the two videos.
```
./clipper <path_to_video1> <path_to_video2>
```
An `mpv` instance should launch, which will playback both videos in a synchronized fashion. To clip, the bindings are `;` (start/reset start) and `'` (stop/reset stop).
When you're done, simply exit out of the player (`q`), and `ffmpeg` will begin to encode the clips into files.
