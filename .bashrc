# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF --color=auto'
alias gg='gcc -std=c99 -pedantic -Werror -Wall -Wextra -Wvla'
alias cm='git commit -m""$1""'
alias status='git status'
alias tag='git tag -ma""$1""'
alias checkout='git checkout'
alias pull='git pull'
alias p='git push origin --follow-tags'
alias tagd='git tag -d'
alias fr='setxkbmap fr'
alias us='setxkbmap us'
alias vi='vim'
alias txf='tar -xvf'
alias tgz='tar -zxvf'
alias tbz='tar -jxvf'
alias x='clear'
alias rm='trash-put'
alias gti='git'
alias sl='ls'
alias mkdir='mkdir -p'
alias clone='git clone'
alias ju='. ~/.virtualenvs/masi-py3/bin/activate
python3 -m jupyter notebook'
alias lint='sqlfluff lint'
alias fix='sqlfluff fix'
alias arc='tar -czf "$1".tar.gz $1'
alias t='tree'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Created by `pipx` on 2025-11-12 19:16:30
export PATH="$PATH:/home/etienne/.local/bin"
fastfetch #affiche le logo
setxkbmap us

# --- Fonction personnalisee --- 
# Fonction personnalisée pour git add + status + branch
add() {
    git add "$@" && git status && git branch
}
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PATH="/usr/lib/postgresql/17/bin:$PATH"


# This creates a command 'l' that lists files and counts them
function n() {
    ls --color=auto "$@"
    echo "----------------"
    local count=$(ls -1 "$@" 2>/dev/null | wc -l)
    echo "Files: $count"
}

# Donne la branch lorsque l'on checkout
function checkout() {
    git checkout "$1" && git branch
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGPORT="5433"
export PGPORT="5444"


# --- CONFIGURATION FINALE APERTURE (Dossiers Bleus & Execs Roses Gras) ---

# 1. Couleurs du listage (ls)
# di=01;36  -> Dossiers en Cyan (Bleu Aperture) GRAS
# ex=01;38;5;218 -> Exécutables en Rose (Companion Cube) GRAS
unset LS_COLORS
export LS_COLORS="di=01;36:ex=01;38;5;218:ln=01;35:*.c=00:*.h=00"

# 2. Prompt Orange et Cyan
export PS1='\[\e]0;\u@\h: \w\a\]\[\e[38;5;208m\]\u@\h\[\e[0m\]:\[\e[38;5;36m\]\w\[\e[0m\]\$ '

# 3. Alias
alias ls='ls --color=auto'
alias l='ls -CF --color=auto'
alias ll='ls -alF' 
