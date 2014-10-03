# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

LOCAL_HOST=`uname -n`
MYHOSTNAME=westeros2

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
[ "$LOCAL_HOST" = $MYHOSTNAME ] && xhost +

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\][\[\033[01;34m\]\w\[\033[00m\]/]\n\$ '
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

# some more ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# workaround for gvim
function gvim () { /usr/bin/gvim -f $* & }

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=~/bin:$PATH:/11.10/Android/android-sdk-linux_x86/tools/
#export GIT_PROXY_COMMAND=~/bin/socks_gw
export EDITOR=gvim

if [ "$LOCAL_HOST" = $MYHOSTNAME ]; then
    if ! pidof conky > /dev/null
    then
        sudo conky -c ~/.conkyrc 2>&1 > /dev/null &
    fi
fi

if [ -f ~/.devsetup ]; then
    if [ -n "$PS1" ]; then
        . ~/.devsetup
        if ! ps -p $PPID -o args | grep mc | grep -v grep; then
            d
        fi
        if [ -n "$ANDROID_SRC" ]; then
            pushd $ANDROID_SRC > /dev/null 2>&1
            . $ANDROID_SRC/build/envsetup.sh > /dev/null
            lunch $LUNCH_TARGET_PRODUCT
            export ANDROID_BUILD_TOP=$ANDROID_SRC
            popd > /dev/null 2>&1
            echo > ~/.gdbinit
            #echo "set sysroot $ANDROID_PRODUCT_OUT/symbols/system" >> ~/.gdbinit
            #echo "set solib-absolute-prefix $ANDROID_PRODUCT_OUT/symbols" >> ~/.gdbinit
            echo "set solib-search-path $ANDROID_DEBUG_PRODUCT_OUT/symbols/system/bin:$ANDROID_DEBUG_PRODUCT_OUT/symbols/system/lib:$ANDROID_DEBUG_PRODUCT_OUT/symbols/system/lib/egl:$ANDROID_DEBUG_PRODUCT_OUT/symbols/system/lib/hw:$ANDROID_PRODUCT_OUT/symbols/system/bin:$ANDROID_PRODUCT_OUT/symbols/system/lib:$ANDROID_PRODUCT_OUT/symbols/system/lib/egl:$ANDROID_PRODUCT_OUT/symbols/system/lib/hw" >> ~/.gdbinit
            echo "set breakpoint pending on" >> ~/.gdbinit
            echo "set print pretty" >> ~/.gdbinit
            echo "set history save on" >> ~/.gdbinit
            echo "" >> ~/.gdbinit
            echo "python" >> ~/.gdbinit
            echo "sys.path.insert(0, '/home/lanaczko/gdb_plugins')" >> ~/.gdbinit
            echo "import offsets" >> ~/.gdbinit
            echo "end" >> ~/.gdbinit
            echo
            echo "[~/.bash.rc] Recreated .gdbinit"
        fi
    fi
fi

if [ "$LOCAL_HOST" != $MYHOSTNAME ]; then
    if [ -z $DISPLAY ]; then
        export DISPLAY=172.28.81.99:0
    fi
fi

export P4PORT=perforce01-igk.intel.com:3666
export P4CHARSET=utf8

if [ -r ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

echo && if [ -x /usr/bin/fortune ];then  fortune; fi
