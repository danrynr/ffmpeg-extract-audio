[![Visitor](https://visitor-badge.laobi.icu/badge?page_id=danrynr.ffmpeg_extract_audio)](https://github.com/danrynr/ffmpeg_extract_audio)

# ffmpeg_extract_audio

A simple shell script to extract audio from video files using ffmpeg.

## Prerequisites

`ffmpeg` with `ffprobe` included.

## Usage

```bash
$ ffmpeg_extract_audio.sh /path/to/directory/with/video/files # Extracts audio from all video files in the directory
```

```bash
$ ffmpeg_extract_audio.sh /path/to/video.mp4
```

_All audio files will be saved in the same directory as the video files._
