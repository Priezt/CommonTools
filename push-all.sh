#!/bin/sh

gitpush(){
	echo ===== $1 =====;
	git push $1 --all;
	git push $1 --tags;
}

for s in $(git remote -v | awk '{print $1}' | sort | uniq) ; do
	gitpush $s;
done

