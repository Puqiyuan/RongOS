#!/bin/bash
dir=~/Bash-Script-Program/*

for file in $dir
do
	if [[ $file == *.patch ]]; then
		echo $file
		Basename=$(basename $file )
		matcher=(${Basename//./ })
		break
	fi
done

echo "The patch file is: "$Basename

echo "The matcher is: "$matcher

for str in $(git log | less | grep commit); do
    if [ $str != "commit" ]; then

		if [[ $str = *$matcher* ]]; then
			point=$str
			break
		fi
    fi
done

echo "The checkout pointer is: "$point

git branch tmp

git checkout tmp

git checkout -f $point

git apply --ignore-whitespace $Basename

git add .

git ci . -m "apply $matcher patch file"

git checkout master

git merge tmp

git branch -d tmp

git add .

git ci . -m "apply $matcher patch file"

git push
