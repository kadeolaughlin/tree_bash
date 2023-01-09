#!/bin/bash

olddir=$PWD;

declare -i dirdepth=0;
#printf ".: $(find $file  -maxdepth 1 -type f | wc -l) total files\n";
#printf ".: $(find $file -maxdepth 1 -not -path '*/[@.]*' -type f | wc -l) total files\n";
function getdirsize {
    cd -- "$1";

    for dir in $(ls -a)
    do
        if [ $dir != "." ] && [ $dir != ".." ] && [ -d $dir ]
        then
            for ((i=0; $i < $dirdepth; i++))
            do
                printf "|   "
            done

            printf "|__ $dir: $(du -s $dir | awk '{print $1;}')\n"
            #printf "|-- $file: $(find $file -maxdepth 1 -not -path '*/[@.]*' -type f | wc -l)\n"
            let dirdepth=$dirdepth+1;
            getdirsize "$dir";
            cd ..;
        fi
    done

    let dirdepth=$dirdepth-1;
}
getdirsize "$1";

cd $olddir;
unset i dirdepth;
