#!/bin/bash
##Based on https://blog.niklasottosson.com/linux/bash-script-simulating-the-tree-command/
olddir=$PWD;

declare -i dirdepth=0;
printf ".: $(find $file -type f | wc -l) total files\n";
function getfilecount {
    cd "$1";

    for file in $(ls -a)
    do
        if [ -d $file ] && [ $file != "$1" ] && [ $file != "$2" ]
        then
            for ((i=0; $i < $dirdepth; i++))
            do
                printf "|   "
            done

            printf "|-- $file: $(find $file -type f | wc -l)\n"
            let dirdepth=$dirdepth+1;
            getfilecount "$file" "$file/..";
            cd ..;
        fi
    done
    let dirdepth=$dirdepth-1;
}
getfilecount "$1" "$1/..";

cd $olddir;
unset i dirdepth;

#printf "\e[1;34m.\e[0m\n";
#function listfiles {
#    cd "$1";
#    for file in *
#    do
#        for ((i=0; $i < $dirdepth; i++))
#        do
#            ##Tab between each level
#            printf "│   ";
#        done
#        ##Print directories with brackets ([directory])
#        if [ -d "$file" ]
#        then
#            printf "├── \e[1;34m$file\e[0m\n";
#            alldirs=$alldirs+1;
#        else
#            printf "├── $file\e[0m\n";
#            allfiles=$allfiles+1;
#        fi
#
#        ##Work our way through the system recursively
#        if [ -d "$file" ]
#        then
#            dirdepth=$dirdepth+1;
#            listfiles "$file";
#            cd ..;
#        fi
#    done
#    ##Done with this directory - moving on to next file
#    let dirdepth=$dirdepth-1;
#}
