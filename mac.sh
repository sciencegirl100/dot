#!/bin/bash

# Heads up: this is untested!

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask keepassxc
brew install htop tmux git neovim awscli docker gh node pyenv

# Shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/bira/g' ~/.zshrc
PLUGINS=("aws" "battery" "docker" "dotnet" "emoji-clock" "gh" "macos" "nmap" "ng" "npm" "pip" "python" "ruby" "tmux" "xcode")
for p in ${PLUGINS[@]}; do
    sed -i "s/plugins=(/plugins=($p /g" ~/.zshrc
done
source ~/.zshrc

# Python Environment
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
source ~/.zshrc
pyenv install 3.10.2
pyenv global 3.10.2
echo "PYTHON NOW: ${pyenv version}"

# Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p $HOME/.config/nvim
cat <<EOT > $HOME/.config/nvim/init.vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
" User-Defined Plugs
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'bounceme/remote-viewer'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-dispatch'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'wellle/tmux-complete.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'Shougo/unite.vim'
" User Config
set number
set numberwidth=4
set updatetime=100
let g:airline_powerline_fonts = 1
let g:airline_theme = 'violet'
let g:signify_disable_by_default = 0
" Initialize plugin system
call plug#end()
EOT

nvim +PlugInstall +q +q
