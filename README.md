# callattendant-resources
A grab-bag of low-tech [callattendant](https://github.com/thess/callattendant)-related materials.

---
## Filtering strategies
* Aggressively prepopulate your 'Permitted' list. This can allow you to be more aggressive with filtering, with fewer false positives.
* If you never receive calls from most area codes, consider adding most of them to the Block Numbers regex:
  
      ^200: B9 - 200 (unused)
      ^201: B9 - 201 (NJ)
      ^202: B9 - 202 (DC)
      ...etc
  See [callattendant-regex-block-NA-area-codes.txt](callattendant-regex-block-NA-area-codes.txt) for a baseline.

* Other regex ideas:
```
[-\d]{12,}: B9 - 12+ numbers + dashes
[\d]{12,}: B9 - 12+ numbers
^$: BN - empty name
^P$: BN - P(rivate)
^O$: BN - O(ut of area)
^[A-Z][0-9]{14}: BN - spam CID (V)
^\+[\d]: B9 - starts with plus
```
* If you have a Panasonic DECT phone, you can delay first ring with Menu, #, 173. This gives callattendant an opportunity to filter/respond first, reducing unwanted ringing. (NOTE: If you have an older Panasonic phone, menu shortcut 173 is called "Ring Once" (select "Yes"), If your menu option is "First Ring", select "1".) Panasonic menu steps for different models can be looked up [here](https://help.na.panasonic.com/answers/how-to-turn-off-the-first-ring-when-using-call-block). Other phones may have this feature -- check your manual. 
  
---
## Modem hardware ideas
* List: https://callboot.net/hardware.html
* List: https://ascendis.com/callerid/modems.php

---
## WAV files

### Tools used:
* `ffmpeg`
* `sox` (to concatenate multiple WAVs into a single WAV)
* `libsox-fmt-mp3`
* https://github.com/pndurette/gTTS

### Intercept (IC) [Special Information Tone](https://en.m.wikipedia.org/wiki/Special_information_tone) (SIT)
* [OGG](https://en.m.wikipedia.org/wiki/File:IC_SIT.ogg)
* `ffmpeg -i IC_SIT.ogg -ar 8000 -ac 1 -acodec pcm_u8 IC_SIT.wav`

### Silence
* https://superuser.com/questions/579008/add-1-second-of-silence-to-audio-through-ffmpeg

* `ffmpeg -y -f lavfi -i anullsrc=channel_layout=mono:sample_rate=8000 -acodec pcm_u8 -t 1 silence-1s.wav`

### Beep
* `ffmpeg -y -f lavfi -i "sine=frequency=825:duration=0.5" -ar 8000 -acodec pcm_u8 beep.wav`

### All others

* `mkdir mp3 wav`
* `gtts-cli "text here" --output "mp3/filename.mp3"`
* `ffmpeg -y -i "mp3/filename.mp3" -ar 8000 -ac 1 -acodec pcm_u8 "wav/filename.wav"`
* `ffmpeg -y -i "mp3/filename.mp3" -ar 8000 -ac 1 -filter:a "atempo=1.2" -acodec pcm_u8 "filename_faster.wav"`


### References
* [Special Information Tone](https://en.m.wikipedia.org/wiki/Special_information_tone)
* https://robocall.devpost.com/submissions/12817-using-the-special-information-tone-for-disconnected-numbers
* [Telcodata.us Area Code + Exchanges lookup](https://www.telcodata.us/search-area-code-exchange-detail)
