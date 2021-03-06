#!/bin/bash

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "\n\tZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "\n\tzsh wget and git Installed\n"
    else
        echo -e "\n\tPlease install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi

[ ! -d ~/.config/myzsh ] && mkdir -p ~/.config/myzsh 

if [ ! -f ~/.zshrc ]; then

    echo -e "\n\tZSH is not started yet\n"
else
    mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d") # backup .zshrc
    echo -e "\n\tBacked up the current .zshrc to .zshrc-backup-date\n"
fi

echo -e "\n\tInstalling oh-my-zsh\n"
if [ -d ~/.config/myzsh/oh-my-zsh ]; then
    echo -e "\n\toh-my-zsh is already installed\n"
    git -C ~/.config/myzsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
elif [ -d ~/.config/myzsh/oh-my-zsh ]; then
    echo -e "oh-my-zsh in already installed at '~/.oh-my-zsh'. Moving it to '~/.config/myzsh/oh-my-zsh'"
    export ZSH="$HOME/.config/myzsh/oh-my-zsh"
    mv ~/.oh-my-zsh ~/.config/myzsh/oh-my-zsh
    git -C ~/.config/myzsh/oh-my-zsh remote set-url origin https://github.com/ohmyzsh/ohmyzsh.git
else   
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.config/myzsh/oh-my-zsh
fi

cp -f .zshrc ~/

mkdir -p ~/.cache/zsh/
if [ -f ~/.zcompdump ]; then
    mv ~/.zcompdump* ~/.cache/zsh/
fi

if [ -d ~/.config/myzsh/oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd ~/.config/myzsh/oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/myzsh/oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

if [ -d ~/.config/myzsh/marker ]; then
    cd ~/.config/myzsh/marker && git pull
else
    git clone --depth 1 https://github.com/jotyGill/marker ~/.config/myzsh/marker
fi

if ~/.config/myzsh/marker/install.py; then
    echo -e "Installed Marker\n"
else
    echo -e "Marker Installation Had Issues\n"
fi

if [ -d ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-colorls ]; then
    cd ~/.config/myzsh/oh-my-zsh/custom/plugins/zsh-colorls && git pull
else
    
    echo -e "\n\t Do you want to install Colorls (y/n)? "; read -r answer    

    if [ "$answer" != "${answer#[Yy]}" ] ;then

    git clone https://github.com/Kallahan23/zsh-colorls ${ZSH_CUSTOM:-~/.config/myzsh/oh-my-zsh/custom}/plugins/zsh-colorls
    sudo apt-get update || sudo yum update || sudo pacman -Syu || sudo dnf update
    sudo apt-get install gcc make -y || sudo pacman -S gcc make || sudo yum -y gcc make || sudo dnf -y gcc make
    sudo apt-get install ruby ruby-dev ruby-colorize -y || sudo pacman -S ruby ruby-dev ruby-colorize || sudo yum -y ruby ruby-dev ruby-colorize
    sudo gem install colorls

cat << EOF >> ~/.zshrc
alias ls="colorls -A"           # short, multi-line
alias ll="colorls -1A"          # list, 1 per line
alias ld="ll"                   # ^^^, NOTE: Trying to move to this for alternate hand commands
alias la="colorls -lA"          # list w/ info
EOF

    else

    echo -e "\n\t Colorls installation cancelled\n"

    fi

fi

ZDOTDIR="~/.config/myzsh/zshrc"
if [ ! -d $ZDOTDIR ]; then
    mkdir -p $ZDOTDIR
fi
# INSTALL FONTS

echo -e "\n\tInstalling Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

if [ -d ~/.config/myzsh/oh-my-zsh/custom/themes/powerlevel10k ]; then
    cd ~/.config/myzsh/oh-my-zsh/custom/themes/powerlevel10k && git pull
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/myzsh/oh-my-zsh/custom/themes/powerlevel10k
fi

if [ -d ~/.fzf ]; then
    cd ~/.fzf && git pull
    ~/.fzf/install --all --key-bindings --completion --no-update-rc --64
else
  
  sudo apt-get install fzf -y


fi



if [[ $1 == "--cp-hist" ]] || [[ $1 == "-c" ]]; then
    echo -e "\nCopying bash_history to zsh_history\n"
    if command -v python &>/dev/null; then
        wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
        cat ~/.bash_history | python bash-to-zsh-hist.py >> ~/.zsh_history
    else
        if command -v python3 &>/dev/null; then
            wget -q --show-progress https://gist.githubusercontent.com/muendelezaji/c14722ab66b505a49861b8a74e52b274/raw/49f0fb7f661bdf794742257f58950d209dd6cb62/bash-to-zsh-hist.py
            cat ~/.bash_history | python3 bash-to-zsh-hist.py >> ~/.zsh_history
        else
            echo "Python is not installed, can't copy bash_history to zsh_history\n"
        fi
    fi
else
    echo -e "\nNot copying bash_history to zsh_history, as --cp-hist or -c is not supplied\n"
fi


# source ~/.zshrc
echo -e "\nSudo access is needed to change default shell\n"

if chsh -s $(which zsh) && $(which zsh) -i -c 'omz update'; then
    echo -e "\n\tZSH installed !! please close terminal and open a new session"
else
    echo -e "\n\tSomething is wrong"
fi
exit


