# the i3 package includes i3wm and other useful packages for e.g. status bar, launch applications...
sudo apt install i3

# change linux mint theme to dark
sudo apt install lxappearance
lxappearance # opens GUI and then it can be changed there manually

# package used to control the brightness with Fn keys in i3
sudo apt install brightnessctl
sudo usermod -aG video $USER
sudo usermod -aG input $USER
REBOOT=true # for this action to take place, it requires a reboot

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

if [ REBOOT ]; then
  sudo reboot
fi
