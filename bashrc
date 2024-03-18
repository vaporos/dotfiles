#!/bin/bash

for i in prompt funcs path manpath
do
  source ~amundson/.bash/$i.sh
done

path_init
manpath_init

set_path
set_manpath

which vim > /dev/null 2>&1
if [ $? == 0 ]; then
    export EDITOR=vim
    export VISUAL=vim
    alias vi=vim
else
    export EDITOR=vi
    export VISUAL=vi
fi

case $(uname) in
    Darwin)
        alias ls="ls -F -G"

        if [ -f /opt/homebrew/etc/bash_completion.d/git-completion.bash ]; then
            source /opt/homebrew/etc/bash_completion.d/git-completion.bash
        elif [ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]; then
            source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
            source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
        fi

        if [ -e $HOME/.iterm2_shell_integration.bash ]; then
            source $HOME/.iterm2_shell_integration.bash
        fi

        export BASH_SILENCE_DEPRECATION_WARNING=1

        ulimit -n 65536
        ;;

    Linux)
        alias ls="ls -F --color"
        ;;

    *)
        alias ls="ls -F"
        ;;
esac

if [ $USER = "root" ]; then
    prompt root
    unset DISPLAY
else
    if [ -f $HOME/.prompt_color ]; then
        prompt $(cat $HOME/.prompt_color)
    else
        prompt host
    fi
fi

alias gpg="gpg --keyserver pgp.mit.edu"
alias more=less
alias rm="rm"; unalias rm

export IGNOREEOF=0
unset LD_LIBRARY_PATH
export PAGER=less
unset MAIL; export MAIL

export PATH=$PATH:/users/amundson/.cargo/bin
export PATH=$PATH:/users/amundson/go/bin
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

if [ -f $HOME/.cargo/bin/sccache ]; then
    export RUSTC_WRAPPER=$HOME/.cargo/bin/sccache
fi
export JUST_SUPPRESS_DOTENV_LOAD_WARNING=1
