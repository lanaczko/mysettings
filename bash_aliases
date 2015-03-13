alias I='sudo zypper install'
alias e='gvim'
alias eb='exec bash'
alias cscope='cscope -d'
alias mv='mv -i'
alias beep='beep -f 120'
alias gitka='gitk --all -n10000 &'
alias gitkaa='gitk --all &'
alias gitg='gitg &'
alias gitc='git clean -dfx'
alias gitr='git reset --hard'
alias gits='git status'
alias gitd='git diff'
alias gitl='git log'
alias tree='tree --charset=ASCII'

#adb aliases
alias adbc='adb connect `cat ~/.adb_ip` && sleep 0.3 && adb remount'
alias adbe='adb disconnect'
alias adbr='adbe && adbc'
alias adbs='adb shell'
alias al='adb logcat'

#UFO_SRC=/opt/Perforce/perforce01-igk.intel.com_3666/lanaczko_ufo_android/gfx_Development/mainline/
if [ x$P4CLIENT = "xufo_devel" ]; then
    UFO_SRC=/opt/Perforce/$P4CLIENT/gfx_Development/mainline/
elif [ x$P4CLIENT = "xufo_igc_dev" ]; then
    UFO_SRC=/opt/Perforce/$P4CLIENT/gfx_Development/
elif [ x$P4CLIENT = "xufo_igc_mainline" ]; then
    UFO_SRC=/opt/Perforce/$P4CLIENT/gfx_Development/mainline/
elif [ x$P4CLIENT = "xufo_1533" ]; then
    UFO_SRC=/opt/Perforce/$P4CLIENT/gfx_Development/
fi

#android aliases
alias cda='cd $ANDROID_SRC'
alias cdi='cd /opt/android-ics/WORKING_DIRECTORY'
alias cdu='cd $UFO_SRC/Source'
alias cdb='cd $UFO_SRC/Tools/Linux'
alias cdm='cd .repo/manifests'
alias cdo='cd $ANDROID_PRODUCT_OUT'
alias cddo='cd $ANDROID_DEBUG_PRODUCT_OUT'
alias cdn='cd /nfs/site/proj;cd ufo'

#simics aliases
alias cdw='cd /home/lanaczko/simics_knllb'

if `grep -q Ubuntu /etc/lsb-release`; then
    alias Install='sudo apt-get install'
else
    alias Install='sudo yum install'
fi

alias csl="echo -e '\0033\0143'"
alias ..='cd ..'
alias enable_alert='PS1="$PS1\a"'

ff()
{
	find . -iname $@
}

rg()
{
	grep -RiHnI "$@" * 2>/dev/null
}

rgrep()
{
    rg "$@"
}

rwg()
{
	grep -RwiHnI $@ *
}

rwgrep()
{
    rwg "$@"
}

