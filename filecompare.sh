dira=$1
dirb=$2

sizea=$(du -s $dira | awk '{print $1;}')
sizeb=$(du -s $dirb | awk '{print $1;}')
filea=$(find $dira -type f | wc -l)
fileb=$(find $dirb -type f | wc -l)

size_difference=$(($sizea - $sizeb))
file_difference=$(($filea - $fileb))
printf "$dira: $filea files\n$dirb: $fileb files\nmissing $file_difference files\n\n"
printf "$dira: $sizea kb\n$dirb: $sizeb kb\nmissing $size_difference kb\n"