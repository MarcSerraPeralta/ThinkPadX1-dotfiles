Config files for Linux Mint 21.3 x86_64 with `i3` as window manager and `tmux` as a "terminal manager". 

To set up the configuration in this repo in a Linux Mint Cinnamon computer, run the following commands:
```
git clone --bare <git-repo-url> $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

chmod +x $HOME/setup_script.sh
bash $HOME/setup_script.sh
```

# Choice explanation

Most of my choices are based on the setup from ThePrimagen (e.g. see [this video](https://www.youtube.com/watch?v=bdumjiHabhQ&t=316s)). 

## Main setup

**Operating System** - `Linux Mint`: I have been using it for quite some years now. I started using it because it comes "out-of-the-box" and has a lot of graphical interfaces.

**Desktop Environment** - `Cinnamon`: the most modern, innovative and full-featured desktop from Linux Mint. My laptop is not a potato so it can handle this fancier desktop environment.

**Window Manager** - `i3`: tiling window manager splits your screen up like a grid and every window goes into a tile. It is not a full desktop environment, that it is why I am using Cinnamon. 
I use it because it is very keyboard-oriented, so I can move around without touching the mouse.

**Terminal Multiplexer** - `tmux`: allows multiple terminal programs to be run inside it, detach them, and attach them back. I use it as a "terminal manager", so with a single terminal window I can have multiple terminal processes running and switch to them with keybindings or fuzzy finding. Again, it is very keyboard-oriented, so I can move around without touching the mouse. I don't use `tmux` panes, each pane occupies the whole window. If I want to have "split" mode, I will do it with `i3`. The reason is that I prefer to keep all the "window/pane" managing at the level of `i3`, and not have a mix between `i3` and `tmux` because it is very likely to lead to confusion. 

**Editor** - `Neovim`: once you learn the Vim motions, you can be very fast editing files and without any overhead that comes with fully-fledged IDEs. I use it because it is keyboard-oriented (again), Vim is the default editor on clusters (so I already know how to use it), and it runs on a terminal so it can be managed by `tmux`. Neovim and Vim are very similar but Neovim has a better community that builds plugins and it is easier to customize (with Lua). 

## Extras/utilities

**Window Switcher/Launcher** - `rofi`: it is like the macOS spotlight bar, which is very useful for starting programs or managing the clipboard.

**Clipboard Manager** - `greenclip`: it has all the functionality that I want (i.e. select previous copied text) and can be integrated with `rofi`.
