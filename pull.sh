#!/bin/bash
noparam() {
	echo No directory supplied!
}

help() {
	echo Usage: pull \<directory\>
	echo Pulls all git repositories in \<directory\>
}

notexist() {
	echo Directory $1 not exist!
}

if [ "$1" == "" ]
then
	noparam
	exit 1
fi

if [ "$1" == "--help" ]
then
	help
	exit 0
fi

if [ ! -d "$1" ]
then
	notexist
	exit 1
fi
DIR=$1
LEN=${#DIR}-1

if [ "${DIR:LEN}" != "/" ]; then
	DIR=$DIR"/"
fi

for dir in $(ls -d $DIR*/)
do
#        echo $dir/.git
	if [ -d $dir/.git ]
	then
		pushd $dir > /dev/null
		echo About to pull project: $dir
		git pull
		echo ... done
		echo
		popd > /dev/null
	fi
done
