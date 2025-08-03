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
# install the LSPs
npm install -g basedpyright
# requirements for neovim-tree-sitter: tree-sitter-cli
wget https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz
gunzip tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64
mv tree-sitter-linux-x64 ~/.local/bin/tree-sitter
# requirements for neovim-tree-sitter: nodejs
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh" # in lieu of restarting the shell
nvm install 22 # Download and install Node.js:
# requirements for neovim-tree-sitter: fd
sudo apt install fd-find
ln -s $(which fdfind) ~/.local/bin/fd
# requirements for python LSP
python3 -m pip install ruff ruff-lsp
# requirements for peek.nvim (live preview of Markdown files): deno
curl -fsSL https://deno.land/install.sh | sh
# requirements for nvim-dap-python (debugger)
export PWD=$(pwd)
mkdir ~/virtual_environments
cd ~/virtual_environments
python3 -m pip install virtualenv
virtualenv debugpy --python=$(which python3)
source debugpy/bin/activate
python -m pip install debugpy
deactivate
cd $PWD

# install fzf to fuzzy-find in the command line
sudo apt install fzf

# requirements for the script to lock the screen with i3lock
sudo apt install xss-lock
sudo apt install scrot
chmod +x .config/i3lock/locking_script.sh # one needs to fetch the dotfiles repository first!

# install tmux
sudo apt install tmux

if [ REBOOT ]; then
  sudo reboot
fi
