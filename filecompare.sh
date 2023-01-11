sizea=$(du -s $1 | awk '{print $1;}')
sizeb=$(du -s $2 | awk '{print $1;}')
filea=$(find $1 -type f | wc -l)
fileb=$(find $2 -type f | wc -l)

size_difference=$(($sizea - $sizeb))
file_difference=$(($filea - $fileb))
printf "$1: $filea files\n$2: $fileb files\nmissing $file_difference files\n\n"
printf "$1: $sizea kb\n$2: $sizeb kb\nmissing $size_difference kb\n"