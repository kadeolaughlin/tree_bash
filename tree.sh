#!/bin/bash
#configuring git
##Based on https://blog.niklasottosson.com/linux/bash-script-simulating-the-tree-command/
olddir=$PWD;
declare -i alldirs=0;
declare -i allfiles=0;
declare -i dirdepth=0;
printf "\e[1;34m.\e[0m\n";
function listfiles {
    cd "$1";
    for file in *
    do
        for ((i=0; $i < $dirdepth; i++))
        do
            ##Tab between each level
            printf "│   ";
        done
        ##Print directories with brackets ([directory])
        if [ -d "$file" ]
        then
            printf "├── \e[1;34m$file\e[0m\n";
            alldirs=$alldirs+1;
        else
            printf "├── $file\e[0m\n";
            allfiles=$allfiles+1;
        fi

        ##Work our way through the system recursively
        if [ -d "$file" ]
        then
            dirdepth=$dirdepth+1;
            listfiles "$file";
            cd ..;
        fi
    done
    ##Done with this directory - moving on to next file
    let dirdepth=$dirdepth-1;
}
listfiles "$1";
printf "\n$alldirs directories, $allfiles files\n"
##Go back to where we started
cd $olddir;
unset i dirdepth;
unset i allfiles;
unset i alldirs;
