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
PS1="${GREEN}\$(echo \"\$nix_develop\")\W${RESET} "

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
alias df="df --human-readable | awk 'NR==1 || /\/$/'"
alias e="exit"
alias lg="lazygit"
alias gd="git diff"
alias gp="git push"
alias cr="cargo run"
alias cb="cargo build"
alias cf="cargo fmt"
alias cc="cargo clippy --fix"
alias shareWithPhone="kdeconnect-cli -n jerry --share"
alias nbr="nvim ~/repos/nixos/config/.bashrc"
alias nil="nvim ~/.config/nvim/init.lua"
alias nhx="nvim ~/repos/nixos/config/home.nix"
alias ns="nvim ~/scratch.txt"
alias mhcn="man home-configuration.nix"
alias lvim="echo you probably meant nvim"
alias snapshot="git diff && git add -A && git commit -m \"Snapshot \" && git push"
alias ss="snapshot"
alias cq5="pandoc --from markdown --to pdf quiz-5.md > quiz-5.pdf && z quiz-5.pdf"
alias ghcs="gh copilot suggest"
alias ghrepolist="gh repo list -L 99"
alias keymaps="bind -P | awk '/can be found/ {print \$0}' | fzf"
alias cal3="cal -3"
alias calyear="cal --year"
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


if [ -z "$in_nvim" ]; then
  kitten @ set-spacing padding=5
fi

function nvim() {
  export in_nvim=1
  kitten @ set-spacing padding=0
  if [[ -n $@ ]]; then 
    command nvim "$@"
  else
    command nvim -S ~/.cache/nvim/session.vim
  fi
  kitten @ set-spacing padding=5
  unset in_nvim
}

function cd() {
    builtin cd "$@"
    clear
    fd --max-depth=1 --color never | column
}

function clone() {
  repo=$(gh repo list -L 99 | awk '/Joel-Singh/ {print $1}' | fzf)
  if [[ -n "$repo" ]]; then
    gh repo clone $repo
  else
    echo "No repo selected."
  fi
}

function n-graph() {
  document=$(fd . /home/apple/repos/Guiding-Principles/ | fzf)
  if [ -z "$document" ]; then
    echo No document selected
  else
    nvim "$document"
  fi
}

function n-config() {
  config=$(fd . /home/apple/.config | fzf)
  if [ -z "$config" ]; then
    echo No config selected
  else
    nvim "$config"
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

function rebuild_manual() {
  sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER &>/home/apple/repos/nixos/nixos-switch.log
}

function rebuild() {
  pushd ~/repos/nixos > /dev/null

  if [ -z "$(git diff --no-ext-diff)" ]; then
    echo "No changes"
    popd
    return 0
  fi

  git diff -U0
  git add -A
  git commit -m "temporary" > /dev/null # Flakes doesn't recognize non-committed files
  echo "NixOS Rebuilding..."
  sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER &>/home/apple/repos/nixos/nixos-switch.log
  is_rebuild_successful=$?
  git reset --soft HEAD^
  if [ $is_rebuild_successful -ne 0 ]; then
    cat nixos-switch.log | grep --color error
  else
    gen=$(nixos-rebuild list-generations | grep current)
    git commit -am "$gen"
    git push --quiet
  fi

  popd > /dev/null
}

if [ -z "$in_nvim" ]; then
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

  export FZF_DEFAULT_COMMAND="fd . $HOME $HOME/.config"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd -t d . $HOME"
  export FZF_COMPLETION_TRIGGER=''
  export PATH=/home/apple/.local/bin:/home/apple/.cargo/bin:/home/apple/Applications/:$PATH
fi


git_root=$(git rev-parse --show-toplevel)
if [ -z "$nix_develop" ] && ls $(echo "$git_root"/flake.nix) &> /dev/null && [ -z "$(pwd | grep nixos)" ]; then
	export nix_develop="ND "
	exec nix develop
fi
