# callattendant-resources
A grab-bag of callattendant-related materials.

## WAV files were generated with:

### Silence
ffmpeg -y -f lavfi -i anullsrc=channel_layout=mono:sample_rate=8000 -acodec pcm_u8 -t 1 silence-1s.wav

### Beep
ffmpeg -y -f lavfi -i "sine=frequency=825:duration=0.5" -ar 8000 -acodec pcm_u8 beep.wav

### All others
gtts-cli "text here" --output "mp3/filename.mp3"
ffmpeg -y -i "mp3/filename.mp3" -ar 8000 -ac 1 -acodec pcm_u8 "wav/filename.wav"
