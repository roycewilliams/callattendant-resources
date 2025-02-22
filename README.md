# callattendant-resources
[callattendant](https://github.com/thess/callattendant) is a simple, self-hosted call-filtering platform for landlines.

This repo is my "grab bag" of supporting info and tools for running callattendant.

---
## Quick overview
* Requirements: only a Pi (or other small PC), Linux, python, [the repo](https://github.com/thess/callattendant), and a voice-compatible USB "hard" modem (see "Hardware" below and in repo)
* Built-in web server with a clean, simple interface (see repo) - no apache/nginx/etc required
* Written in clean, legible, and simple Python
* Does not sit between the wall and a phone - instead, it just listens on another extension ("blocking" by picking up and then immediately hanging up)
* Customizable caller-facing voice menus ("press one if you're a human", etc.)
* Can allow or block callers based on either lists, or regular expressions
* No artificial limits on how many numbers it can allow or block
* Some tech savvy required for initial setup, but web interface is designed to be simple (learning regexes isn't required unless you need them)

---
## Startup and tools
* The original author of callattendant assumed that folks would add their own startup / shutdown for the program.
* The shell scripts in the top of this repo are a simple (not systemd) way to do so.
* @telnetdoogie maintains a [Dockerized version](https://github.com/telnetdoogie/callattendant-docker)

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
* Most widely tested: the EOL but robust U.S. Robotics USR5637, [flashed to the last relase of its firmware](https://github.com/roycewilliams/callattendant-resources/tree/main/modem-info/usr5637). Can be expensive (US$70 or more), even on eBay. (I have a few that I bought in a lot I can sell you at cost ($50 shipped), if you have trouble finding one -- already flashed!)
* Another modem commonly used: the Dell RD02-D400. It requires a specific init string to work with callattendant (thess's fork applies this automatically)
* List: https://callboot.net/hardware.html
* List: https://ascendis.com/callerid/modems.php

---
## WAV files
* Need to be converted to a specific format to be used by the modem

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
