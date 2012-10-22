# I like color. Easier to read
autoload colors && colors

# I know VI more than Emacs
set -o vi

# Don't clobber files
set -o noclobber

# My Shell Prompt
PS1="%{$fg[magenta]%}%h%{$reset_color%}][%{$fg[red]%}%n%{$reset_color%}][%{$fg[blue]%}%m%{$reset_color%}][%{$fg[yellow]%}%~%{$reset_color%}§ "