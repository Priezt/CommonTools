#!/bin/sh

gitpush(){
	echo ===== $1 =====;
	git push $1 master;
}

for s in $(git remote -v | awk '{print $1}' | sort | uniq) ; do
	gitpush $s;
done

