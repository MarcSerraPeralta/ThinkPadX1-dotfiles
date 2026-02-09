# My config for my ThinkPad X1 Yoga

Config files for Linux Mint 21.3 x86_64 with `i3` as window manager and `tmux` as a "terminal manager". 

To set up the configuration in this repo in a Linux Mint Cinnamon computer, run the following commands (and check the comments below):
```
wget https://raw.githubusercontent.com/MarcSerraPeralta/ThinkPadX1-dotfiles/refs/heads/master/pre_setup_script.sh
chmod +x pre_setup_script.sh
bash pre_setup_script.sh

git clone --bare <git-repo-url> $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

chmod +x post_setup_script.sh
bash post_setup_script.sh
```

**1.** Open Cinnamon settings (or run `cinnamon-settings`) and change the Power Management as you wish. 
My configuration is that closing the lid only locks the screen to avoid broken connections to clusters through ssh and simulations being stopped. 

*Note: IDK why but I didn't have any Power Manager, so I had to run `sudo apt install xfce4-power-manager`.*

**2.** Ensure that the screen gets locked after going into sleep mode (for security purposes). 
In Cinnamon, this is configured in Cinnamon settings (which can be open by running `cinnamon-settings`).

**3.** Install a nerd font so that the icons in Neovim are displayed correctly. 
I am using [this Ubuntu Mono font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip).
Neovim uses the font from the terminal, so one just needs to change that (Terminal > Preferences > Font). 
If the newly installed font does not show up in the terminal as option, close all terminal windows to restart the terminal.
If the issue still persists, maybe install the font system wide, check using `fc-list :spacing=mono` the available monospaced fonts, restart the cache with `fc-cache -fv`...

**4.** Set up the battery notifications using cron. Run `crontab -e` and then add to the end of the file:
```
*/3 * * * * /home/marc/.local/bin/battery_notifications
```
with `/home/marc/` substituted for your home path. 
This means that the battery-notification script will run every 3 minutes. 
The reason for not using `$HOME` is that cron does not have all the environment variables loaded up. 
For this reason, you must also check the `battery_notifications` script and update any environment variables present there.

**5.** Install the following plugins in Mozilla Firefox:
- uBlock Origin
- Dark reader
- Google Scholar
- Grammarly
- Firefox Color
- Control Panel for YouTube

**6.** Set up the monitor configurations in `autorandr` for automatic detection using
```
autorandr --save <name>
```


# Choice explanation

Most of my choices are based on the setup from ThePrimeagen (e.g. see [this video](https://www.youtube.com/watch?v=bdumjiHabhQ&t=316s)). 


## Main setup

**Operating System** - `Linux Mint`: I have been using it for quite some years now. 
I started using it because it comes "out-of-the-box" and has a lot of graphical interfaces.

**Desktop Environment** - `Cinnamon`: the most modern, innovative and full-featured desktop from Linux Mint. 
My laptop is not a potato so it can handle this fancier desktop environment.

**Window Manager** - `i3`: tiling window manager splits your screen up like a grid and every window goes into a tile. 
It is not a full desktop environment, that it is why I am using Cinnamon. 
I use it because it is very keyboard-oriented, so I can move around without touching the mouse.

**Terminal Multiplexer** - `tmux`: allows multiple terminal programs to be run inside it, detach them, and attach them back. 
I use it as a "terminal manager", so with a single terminal window I can have multiple terminal processes running and switch to them with keybindings or fuzzy finding. Again, it is very keyboard-oriented, so I can move around without touching the mouse. I don't use `tmux` panes, each pane occupies the whole window. If I want to have "split" mode, I will do it with `i3`. The reason is that I prefer to keep all the "window/pane" managing at the level of `i3`, and not have a mix between `i3` and `tmux` because it is very likely to lead to confusion. 

**Editor** - `Neovim`: once you learn the Vim motions, you can be very fast editing files and without any overhead that comes with fully-fledged IDEs. I use it because it is keyboard-oriented (again), Vim is the default editor on clusters (so I already know how to use it), and it runs on a terminal so it can be managed by `tmux`. Neovim and Vim are very similar but Neovim has a better community that builds plugins and it is easier to customize (with Lua). 

**Terminal** - `gnome-terminal`: default terminal in Linux Mint, which is sufficient for what I need.


## Extras/utilities

**Window Switcher/Launcher** - `rofi`: it is like the macOS spotlight bar, which is very useful for starting programs or managing the clipboard.

**Clipboard Manager** - `greenclip`: it has all the functionality that I want (i.e. select previous copied text) and can be integrated with `rofi`.
