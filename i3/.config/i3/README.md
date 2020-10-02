# i3wm documentation
i3wm config file is located in .config/i3/config. <br/>
All the default keybinding are located in the i3wm config file. <br/>
## Config
Create i3 config file with following command:
```
i3-config-wizard
```
## Multimedia
Enabling multimedia keys: <br/>
https://faq.i3wm.org/question/3747/enabling-multimedia-keys/?answer=3759#post-id-3759

Playerctl package is not installed on OS by default, and the playerctl package can't be found in the package manager. <br/>
The solutions is to install playerctl package from github: <br/>
https://github.com/acrisci/playerctl <br/>
Download playerctl package from github and run:
```
sudo dpkg -i package-name
```

## Background
Use feh package to get background image in i3wm:
```
sudo apt-get install feh
```
```
exec_always feh --bg-scale absolute-path-to-wallpaper
```

## Monitor management
There is no gui in i3wm, use the default command-line xrandr or the recommended arandr package to setup up multiple monitors.
```
sudo apt-get install arandr 
```
Open arandr with the mod+d command. <br/>

Use exec_always technique to execute the saved .screenlayout/path-to-file with xrandr monitor settings from arandr program.
```
exec_always xrandr ...
```

## Workspaces
Use variables to avoid typos.
```
set $workspace1 "1: Development"

# switch to workspace
bindsym $mod+1 workspace $workspace1

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $workspace1 
```
### Startup programs in Workspaces
Use xprop in terminal to get window class of the program. <br/>
On startup start emacs in workspace 1 example.
```
assign [class="Emacs"] $workspace1
exec emacs
```
i3wm assign spotify on OS.
```
for_window [class="Spotify"] move to workspace $workspace10
assign [class="Spotify"] $workspace10
exec spotify
```
## Rice i3wm
Tips and tricks to make i3wm look better.<br/>
Yosemite San Francisco Font.
https://github.com/supermarin/YosemiteSanFranciscoFont
Download font from github. <br/>
Unzip folder
```
cd ~/Downloads
unzip Yosemitesanfranciscofont.zip
```
Move all the .ttf files to .fonts folder
```
cd ~/Downloads/YosemiteSanFranciscoFont-master
mv *ttf ~/.fonts/
```
Add fonts to i3wm config file
```
font pango:System San Francisco Display 11
```
