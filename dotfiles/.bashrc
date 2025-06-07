#
# ~/.bashrc
#
#

export VISUAL="nvim"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export JOELS_COMPUTER="true" # Used for DuckSlayer

# Added default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Customizing Bash prompt
GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
PS1="${GREEN}\W${RESET} "

# Aliases
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias pacman='pacman --color=auto'
alias rm='echo Use trash silly'
alias trp='trash-put --verbose'
alias trp-downloads='trash-put --verbose ~/Downloads/*'
alias kcli='kdeconnect-cli'
alias c="clear && printf '\033[3J'; fd --max-depth=1 --color never | column "
alias xterm='xterm & disown'
alias df="df --human-readable | awk 'NR==1 || /sda2/'"
alias e="exit"
alias lg="lazygit"
alias gd="git diff"
alias cr="cargo run"
alias cb="cargo build"
alias cf="cargo fmt"
alias cc="cargo clippy --fix"
alias shareWithPhone="kdeconnect-cli -n jerry --share"
alias nbr="nvim ~/Personal/dotfiles/.bashrc"
alias nhc="nvim ~/Personal/dotfiles/hyprland.conf"
alias nil="nvim ~/nvim/init.lua"
alias ns="nvim ~/Personal/Temporary/scratch.txt"
alias nmd="nvim ~/Personal/Temporary/scratch.md"
alias npy="nvim ~/Personal/Temporary/scratch.py"
alias lvim="echo you probably meant nvim"
alias snapshot="git add -A && git commit -m \"Snapshot \" && git push"
alias ss="snapshot"
alias cq5="pandoc --from markdown --to pdf quiz-5.md > quiz-5.pdf && z quiz-5.pdf"
alias ghcs="gh copilot suggest"
alias ghrepolist="gh repo list -L 99"
alias keymaps="bind -P | awk '/can be found/ {print \$0}' | fzf"
alias cal3="cal -3"
alias calyear="cal --year"
alias n-graph='nvim "$(fd . /home/apple/Personal/Guiding-Principles/ | fzf)"'
alias pdft='mkdir -p output && pdflatex -output-directory=./output'
alias neofetch='fastfetch'
alias ff='fastfetch'
alias zcs="z /home/apple/Personal/Denison/spring-2024/CS234/cs234-book.pdf"
alias ztn='ls /home/apple/Personal/Denison/spring-2024/MATH145/teacher-notes/ | $(echo z /home/apple/Personal/Denison/spring-2024/MATH145/teacher-notes/$(fzf)) && exit'
alias mv="mv -i"
alias qq="qalc"
alias qalc="clear && qalc"
alias calc="clear && qalc"
alias cp="cp --update=none-fail"

function z() {
  nohup zathura "$@" >/dev/null & disown & e
}

function launch_gnucash() {
  nohup gnucash ~/gnucash/myMainMoneyFile.gnucash > /dev/null & disown & e
}

if [ -z "$NVIM" ]; then
  kitten @ set-spacing padding=5
fi
function nvim() {
  kitten @ set-spacing padding=0
  if [[ -n $@ ]]; then 
    command nvim "$@"
  else
    command nvim # -S ~/nvim/Session.vim
  fi
  kitten @ set-spacing padding=5
}

function cd() {
    builtin cd "$@"
    clear
    fd --max-depth=1 --color never | column
}

function y-S() {
  if [[ -z $1 ]]; then
    echo "Usage: y-S <package>"
    return
  fi

  pkg=$(yay -Ss $1 | awk '/^[a-z]/ {print $1}' | fzf -q ${1})
  if [[ -n $pkg ]]; then
    yay -S $pkg
  fi
}

function p-S() {
  if [[ -z $1 ]]; then
    echo "Usage: p-S <package>"
    return
  fi

  pkg=$(yay -Ss $1 | awk '/^[a-z]/ {print $1}' | awk '!/^aur/' | fzf -q ${1})
  if [[ -n $pkg ]]; then
    sudo pacman -S $pkg
  fi
}

function p-R() {
  pkg=$(pacman -Qq | fzf -q ${1:-""})
  if [[ -n "$pkg" ]]; then
    sudo pacman -Rs "$pkg"
  else
    echo "No package selected."
  fi
}

function clone() {
  repo=$(gh repo list -L 99 | awk '/Joel-Singh/ {print $1}' | fzf)
  if [[ -n "$repo" ]]; then
    gh repo clone $repo
  else
    echo "No repo selected."
  fi
}


function viewMd() {
  pandoc "$1" -o "/home/apple/Personal/Temporary/viewMdFile.pdf" && z "/home/apple/Personal/Temporary/viewMdFile.pdf"
}

function toPdf() {
  pandoc "$1" -o "${1%.*}.pdf"
}

function toMd() {
  pandoc "$1" -o "${1%.*}.md"
}

function runCpp() {
  ls *.cpp | entr -c sh -c "g++ $1 -o ${1%.*} && ./${1%.*}"
}

function runCppMake() {
  ls *.cpp | entr -c sh -c "make && $1"
}

function runTestCpp() {
  ls *.cpp | entr -c sh -c "$1"
}

function runPython() {
  ls *.py | entr -c sh -c "python $1"
}

function timer() {
  termdown "$1" --no-bell && notify-send "Time's up!" $2
}

function rebuild() {
  pushd ~/Repos/nixos
  git diff -U0
  echo "NixOS Rebuilding..."
  sudo nixos-rebuild switch --flake ~/Repos/nixos\#nixos &>nixos-switch.log
  if [ $? -ne 0 ]; then
    cat nixos-switch.log | grep --color error
  else
    gen=$(nixos-rebuild list-generations | grep current)
    git commit -am "$gen"
  fi

  git push
  if [ $? -ne 0 ]; then
    echo "Failed to push!"
  fi
  popd
}

bind '"\t":menu-complete'

set keyseq-timeout 25
# History Settings
HISTFILESIZE=1000000
HISTSIZE=1000000
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
PROMPT_COMMAND="$PROMPT_COMMAND;pwd > /tmp/currentwd"

# fzf and fd shortcuts
# CTRL-T to fuzzily search for a file or directory in your home directory then insert its path at the cursor
#
# ALT-C to fuzzily search for a directory in your home directory then cd into it
#
# CTRL-R to fuzzily search your command line history then run an old command

if command -v fzf-share >/dev/null; then
	source "$(fzf-share)/completion.bash"
	source "$(fzf-share)/key-bindings.bash"
fi

export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_COMPLETION_TRIGGER=''
export PATH=/home/apple/.local/bin:/home/apple/.cargo/bin:/home/apple/Applications/:$PATH

fd --max-depth=1 --color never | column
