# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="afowler"

plugins=(git oc copybuffer)

source $ZSH/oh-my-zsh.sh

# colors
echo -ne "\e]12;orange\007"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:"
export EXA_COLORS="uu=38;5;255:gu=38;5;255:ur=38;5;255:uw=38;5;255:ue=38;5;255:wx=38;5;255:gr=38;5;250:gw=38;5;250:gx=38;5;250:tr=38;5;255:tw=38;5;255:tx=38;5;255:da=38;5;250:sn=32:sb=0:di=38;5;105"

autoload zmv

source ~/.aliases

set -o noclobber


xset r rate 200 50

