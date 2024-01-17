# callattendant-resources
A grab-bag of callattendant-related materials.

## WAV files were generated with:

### Tools used:
* ``ffmpeg`
* `sox`
* `libsox-fmt-mp3`
* https://github.com/pndurette/gTTS

## Intercept (IC) [Special Information Tone](https://en.m.wikipedia.org/wiki/Special_information_tone) (SIT)
* [OGG](https://en.m.wikipedia.org/wiki/File:IC_SIT.ogg)
* ffmpeg -i IC_SIT.ogg -ar 8000 -ac 1 -acodec pcm_u8 IC_SIT.wav

### Silence
* https://superuser.com/questions/579008/add-1-second-of-silence-to-audio-through-ffmpeg

* `ffmpeg -y -f lavfi -i anullsrc=channel_layout=mono:sample_rate=8000 -acodec pcm_u8 -t 1 silence-1s.wav`

### Beep
* `ffmpeg -y -f lavfi -i "sine=frequency=825:duration=0.5" -ar 8000 -acodec pcm_u8 beep.wav`

### All others

* `gtts-cli "text here" --output "mp3/filename.mp3"`
* `ffmpeg -y -i "mp3/filename.mp3" -ar 8000 -ac 1 -acodec pcm_u8 "wav/filename.wav"`

### References
* (Special Information Tone)[https://en.m.wikipedia.org/wiki/Special_information_tone]
* https://robocall.devpost.com/submissions/12817-using-the-special-information-tone-for-disconnected-numbers
