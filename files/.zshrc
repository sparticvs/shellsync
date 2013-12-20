# I like color. Easier to read
autoload colors && colors

# Disable Python Byte Code
export PYTHONDONTWRITEBYTECODE=1

# I know VI more than Emacs
# set -o vi # I apparently needed some emacs bindings :-P

# Don't clobber files
set -o noclobber

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
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
if [ -z "$TMUX" ]; then
    base_session='sparticvs_session'
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
PS1="%{$fg[magenta]%}%h%{$reset_color%}][%{$fg[red]%}%n%{$reset_color%}][%{$fg[blue]%}%m%{$reset_color%}][%{$fg[yellow]%}%~%{$reset_color%}§ "
