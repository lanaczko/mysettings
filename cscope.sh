#!/bin/bash

#LNX=/home/lanaczko/repos/hwloc

if [ -z $LNX ]; then
    echo 'Set $LNX please!'
    exit 1
fi

if [ x"$1" = "x-g" ]; then
    rm csope.files cscope.out
    find  $LNX                                                            \
    -path "$LNX/tmp*" -prune -o                                           \
    -path "$LNX/Documentation*" -prune -o                                 \
    -name "*.[chxsS]" -print -o -name "Kconfig" -print -o -name "*.cpp" -print >cscope.files

    echo "No. of files to process `wc -l cscope.files`"

    cscope -b -q -k
fi

if [ ! -z $1 ]; then
    EDITOR=vim cscope -d
else
    cscope -d
fi
