# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

export ZSH=$HOME/.oh-my-zsh

# I like color. Easier to read
autoload colors && colors

# Disable Python Byte Code
export PYTHONDONTWRITEBYTECODE=1

# I know VI more than Emacs
# set -o vi # I apparently needed some emacs bindings :-P

# Don't clobber files
set -o noclobber

if [ $(uname) = "Darwin" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=always'
fi
# alias grep='grep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# I want to keep shell history
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$HOME/.zsh_history

# Default to TMUX config
#
# This might be too clever. But it allows me to have multiple
# sessions opened and it will use the same windows. This really
# makes TMUX work like SCREEN.
if [ -z "$TMUX" ] && [ -z "$DISPLAY" ] && [ -z "$TERM_PROGRAM" ]; then
    base_session="${USER}_session"
    # Create a new session if it doesn't exist
    tmux has-session -t $base_session || tmux new-session -d -s $base_session

    client_cnt=$(tmux list-clients | wc -l)
    # Are there any clients connected already?
    if [ $client_cnt -ge 1 ]; then
        client_id=0
        session_name=$base_session"-"$client_id
        while [ $(tmux has-session -t $session_name 2>& /dev/null; echo $?) -ne 1 ]; do
            client_id=$((client_id+1))
            session_name=$base_session"-"$client_id
        done
        tmux new-session -d -t $base_session -s $session_name
        tmux -2 attach-session -t $session_name \; set-option destroy-unattached
    else
        tmux -2 attach-session -t $base_session
    fi
fi

PYTHONENV="$HOME/.pyenv/"

if [ -z "$PYHTONENV/bin/activate" ]; then
    source $PYTHONENV/bin/activate
fi

# My Shell Prompt
export DISABLE_UNTRACKED_FILES_DIRTY="true"
#ZSH_THEME="sparticvs"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git brew vagrant virtualenv)
setopt prompt_subst
source $ZSH/oh-my-zsh.sh
unset LSCOLORS

export EDITOR=vim
export PATH=$HOME/Library/Android/sdk/platform-tools:$HOME/.cargo/bin:$PATH:/usr/local/share/npm/bin
alias python=/usr/local/bin/python3.6

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
