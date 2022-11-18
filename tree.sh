#!/bin/bash

olddir=$PWD;

declare -i dirdepth=0;
printf ".: $(find $file  -maxdepth 1 -type f | wc -l) total files\n";
#printf ".: $(find $file -maxdepth 1 -not -path '*/[@.]*' -type f | wc -l) total files\n";
function getfilecount {
    cd -- "$1";

    for file in $(ls -a)
    do
        if [ -d $file ] && [ $file != "." ] && [ $file != ".." ]
        then
            for ((i=0; $i < $dirdepth; i++))
            do
                printf "|   "
            done

            printf "|__ $file: $(find $file  -maxdepth 1 -type f | wc -l)\n"
            #printf "|-- $file: $(find $file -maxdepth 1 -not -path '*/[@.]*' -type f | wc -l)\n"
            let dirdepth=$dirdepth+1;
            getfilecount "$file";
            cd ..;
        fi
    done
    let dirdepth=$dirdepth-1;
}
getfilecount "$1";

cd $olddir;
unset i dirdepth;
