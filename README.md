# my-zsh

![my-zsh](https://github.com/mayur-chavhan/my-zsh/blob/main/my-zsh.webp)
A simple script to setup an awesome shell environment.
Quickly install and setup zsh and oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh) with
* powerlevel10k theme (https://github.com/romkatv/powerlevel10k)
* Nerd-Fonts (https://github.com/ryanoasis/nerd-fonts)
* zsh-completions (https://github.com/zsh-users/zsh-completions)
* zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
* zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
* history-substring-search (https://github.com/zsh-users/zsh-history-substring-search)
* fzf (https://github.com/junegunn/fzf)

Sets following useful aliases:
* l="ls -lah"         - just type "l" instead of "ls -lah"
* alias k="k -h"	  - show human readable filesizes, in kb, mb etc
* x="exit"
* https               - make httpie use https
* myip - (wget -qO- https://wtfismyip.com/text)       - what's my ip: quickly find out external IP
* cheat - (https://github.com/chubin/cheat.sh)        - cheatsheets in the terminal!
* speedtest - (curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -) run speedtest on the fly
* dadjoke - (curl https://icanhazdadjoke.com)         - terminally sick jokes
* dict - (curl "dict://dict.org/d:$1 $2 $3")          - dictionary definitions
* ipgeo - (curl "http://api.db-ip.com/v2/free/$1")    - finds geo location from IP
* corona - (curl "https://corona-stats.online/")      - shows corona virus spread live stats

Install Colorls with ls aliases and its ruby's dependency.

### Script will ask you wether your want to install colorls with ruby packages and it will add lines in zshrc.

* alias ls="colorls -A"           # short, multi-line
* alias ll="colorls -1A"          # list, 1 per line
* alias ld="ll"                   # ^^^, NOTE: Trying to move to this for alternate hand commands
* alias la="colorls -lA"          # list w/ info

## Installation
Requirements:
* `git` to clone it.
* `python3` or `python` is required to run option '-c' which copies history from .bash_history

``` bash
git clone https://github.com/mayur-chavhan/my-zsh.git
cd my-zsh
./install-my-zsh.sh -c        # only run with '-c' the first time, running multiple times will duplicate history entries
```

Change your terminals fonts to either "RobotoMono Nerd Font" or "Hack Nerd Font" or "DejaVu Sans Mono Nerd Fonts".
You can also manually install Nerd Fonts of your choice.

