# Haze-Conky-Theme
Awesome Conky Theme that displays system info, Spotify status, current weather, forecast, email and calendar updates!

# Requirements
- Conky 1.19.8
- Cairo
- Playerctl
- Jq
- ffmpeg
- Geary
- Spotify (flatpak)
- Sed (formatting)
- Sensors (CPU temperature)
- CalCurse (calendar)
- xmlstarlet
- ccmake
- Git (for cloning this repo)
- I *really* reccommend installing Conky Manager ```sudo add-apt-repository ppa:teejee2008/foss sudo apt update sudo apt install conky-manager2```
# Installation
1. Install the required dependencies if they aren't already installed

```sudo apt-get install calcurse xmlstarlet jq lm-sensors geary libcairo2-dev ccmake ffmpeg playerctl sed git```


2. Clone the repo in your ~/.config/conky directory

3. Go to the Conky Github repo https://github.com/brndnmtthws/conky/tree/v1.19.8 and download version 1.19.8. Follow instructions from the wiki to build it, preferably using ccmake and enabling every Lua parameter and mouse events (or the interesting parts of this theme won't work)

4. Play with the ```offset```, ```voffset``` and ```align``` variables

# Setting preferences and widgets

You'll need to manually set some stuff
- Haze
1. In the ```bars.lua``` script, change your network address with your own (run ```ip addr show``` on the terminal)

- Haze Media: this theme supports click events!
1. Gmail:Go to https://support.google.com/accounts/answer/185833?hl=en and follow instructions (you'll ned to enable 2-step verification on your Google account). Copy the 16-digit password (delete blank spaces), and fill the ```gmail.sh``` script. Clicking on the email icon will launch Geary. If you don't use Geary or any email client, change ```os.execute``` from ```geary``` to your method of preference (a browser, for example) in the ```music-controls.lua``` script.

2. Spotify cover art: in the ```fetch-art2``` script you'll find that you can add album covers of manually downloaded music in the ```data``` directory. Name the images as instructed in the script. 

3. Music Controls: if you click the Spotify icon, you'll launch Spotify (only flatpak, you can change the ```os.execute``` parameter to ```spotify``` instead of the current ```flatpak run com.spotify.Client``` in the ```music-controls.lua``` script). You can click on the control icons to play/pause songs, go to previous or next tracks. 

4. Weather: go to OpenWeathermap.org to get your API Key and cityID and fill ```weather-v2.0.sh``` and ```forecast.sh``` scripts with them.

- Haze Calendar
1. You need ```Calcurse``` to display calendar events.

2. Clicking on the calendar widget will launch an instance of ```gnome-terminal``` with Calcurse. If you don't use ```gnome-terminal```, change it to your terminal of preference.


# Tested Enviroment
This theme was made on Pop!_OS 22.04 using GNOME 42.9. 

# Screenshot

<img width="1883" height="989" alt="a" src="https://github.com/user-attachments/assets/d481c2ba-c78f-49c5-81a1-c66ef20a8f3f" />


# License 
This project is licensed under the GPL-3.0 License. See the License file for details.


