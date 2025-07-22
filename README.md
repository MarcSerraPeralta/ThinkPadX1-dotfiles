Config files for Linux Mint 21.3 x86_64 with `i3` as window manager. 

# Setup script

```
# the i3 package includes i3wm and other useful packages for e.g. status bar, launch applications...
sudo apt install i3

# change linux mint theme to dark
sudo apt install lxappearance
lxappearance # opens GUI and then it can be changed there manually

# package used to control the brightness with Fn keys in i3
sudo apt install brightnessctl
sudo usermod -aG video $USER
sudo usermod -aG input $USER
# requires restarting the computer!

# package used to set up a wallpaper
sudo apt install feh

# package used to have the "spotlight bar" from macOS
sudo apt install rofi

# Source/update config from .Xresources for display scaling
xrdb ~/.Xresources

# greenclip for clipboard
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
sudo mv greenclip /usr/local/bin/greenclip
sudo chmod +x /usr/local/bin/greenclip

# install latest version of Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
# set vim to be neovim
sudo update-alternatives --install /usr/bin/vim vim "/opt/nvim-linux-x86_64/bin/nvim" 100
sudo update-alternatives --set vim "/opt/nvim-linux-x86_64/bin/nvim"
# set neovim as default editor
sudo update-alternatives --install /usr/bin/editor editor "/opt/nvim-linux-x86_64/bin/nvim" 100
sudo update-alternatives --set editor "/opt/nvim-linux-x86_64/bin/nvim"
# requirement for neovim
sudo apt install ripgrep
sudo apt install xclip # to access the system's clipboard

# install fzf to fuzzy-find in the command line
sudo apt install fzf

# requirements for the script to lock the screen with i3lock
sudo apt install scrot
chmod +x .config/i3lock/locking_script.sh # one needs to fetch the dotfiles repository first!
```

# Choice explanation

Most of my choices are based on the setup from ThePrimagen (e.g. see [this video](https://www.youtube.com/watch?v=bdumjiHabhQ&t=316s)). 

## Main setup

**Operating System** - `Linux Mint`: I have been using it for quite some years now. I started using it because it comes "out-of-the-box" and has a lot of graphical interfaces.

**Desktop Environment** - `Cinnamon`: the most modern, innovative and full-featured desktop from Linux Mint. My laptop is not a potato so it can handle this fancier desktop environment.

**Window Manager** - `i3`: tiling window manager splits your screen up like a grid and every window goes into a tile. It is not a full desktop environment, that it is why I am using Cinnamon. 
I use it because it is very keyboard-oriented, so I can move around without touching the mouse.

**Terminal Multiplexer** - `tmux`: allows multiple terminal programs to be run inside it, detach them, and attach them back. I use it as a "terminal manager", so with a single terminal window I can have multiple terminal processes running and switch to them with keybindings or fuzzy finding. Again, it is very keyboard-oriented, so I can move around without touching the mouse.

**Editor** - `Neovim`: once you learn the Vim motions, you can be very fast editing files and without any overhead that comes with fully-fledged IDEs. I use it because it is keyboard-oriented (again), Vim is the default editor on clusters (so I already know how to use it), and it runs on a terminal so it can be managed by `tmux`. Neovim and Vim are very similar but Neovim has a better community that builds plugins and it is easier to customize (with Lua). 

## Extras/utilities

**Window Switcher/Launcher** - `rofi`: it is like the macOS spotlight bar, which is very useful for starting programs or managing the clipboard.

**Clipboard Manager** - `greenclip`: it has all the functionality that I want (i.e. select previous copied text) and can be integrated with `rofi`.
