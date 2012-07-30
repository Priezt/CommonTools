#!/bin/bash

TMPBASE=/tmp
TMPDIR=$TMPBASE/pack-env-tmp
PACKFILE=$HOME/env.tar

rm $PACKFILE
rm -rf $TMPDIR
mkdir $TMPDIR

cp $HOME/.bashrc $TMPDIR/
cp $HOME/.bash_profile $TMPDIR/
cp $HOME/.tmux.conf $TMPDIR/
cp $HOME/.vimrc $TMPDIR/
cp -R $HOME/.ssh $TMPDIR/.ssh
cp -R $HOME/code $TMPDIR/code
cp -R $HOME/memo $TMPDIR/memo
cp -R $HOME/tools $TMPDIR/tools
mkdir $TMPDIR/crontab
crontab -l > $TMPDIR/crontab/crontab.txt

cd $TMPBASE
tar cf $PACKFILE pack-env-tmp
gzip $PACKFILE

rm -rf $TMPDIR


