#!/bin/bash

process_file() {
    input_file="$1"
    input_filename=$(basename "$input_file")
    output_filename="${input_filename%.*}"

    audio_codec=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input_file" | head -n 1)

    # trimmed_audio_codec="${audio_codec##*( )}"
    trimmed_audio_codec=$(echo "$audio_codec" | tr -cd '[:alnum:]')

    echo "Detected audio codec: $trimmed_audio_codec"
    output_extension="$trimmed_audio_codec"

    output_path="$(dirname "$input_file")/$output_filename.${output_extension}"


    ffmpeg -i "$input_file" -vn -acodec copy -y "$output_path" -loglevel quiet -stats

    echo "Done."
}

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 input_path"
    exit 1
fi

# Get the provided input path
input_path="$1"

# Array of most common video format
video_extensions=("*.mp4" "*.mkv" "*.ts" "*.avi" "*.mov" "*.flv" "*.wmv" "*.m4v" "*.webm" "*.vob" "*.mpg" "*.mpeg" "*.3gp" "*.ogv")

# Create an array of find options
find_options=()
for ext in "${video_extensions[@]}"; do
    find_options+=(-o -iname "$ext")
done

# Remove the first element (-o) from the array
find_options=("${find_options[@]:1}")

# Check if the input path is only a directory
if [ -d "$input_path" ]; then
    find "$input_path" -type f \( "${find_options[@]}" \) -print0 | while IFS= read -r -d '' file; do
        process_file "$file"
	done
else
    process_file "$input_path"
fi
