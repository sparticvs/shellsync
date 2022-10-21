shellsync
=========

I use ``zsh`` and ``tmux`` and I work on a variety of different Linux hosts and I am tired of copying configurations around or updating a bug in one and not fixing it in all of the shells.

usage
---------
```
$ # clone this repo
$ cd <repo>
$ git submodules update --init
$ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
$ python3 shellsync.py
```

On Sodalite/elementaryOS, after installing fonts from P10K's repo run
```
$ gsettings set io.elementary.terminal.settings font "MesloLGS NF"
```
