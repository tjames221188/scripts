#!/bin/bash

nocommand() {
	echo No command supplied!
	exit 1
}

help() {
	echo Usage: gits.sh \<commands...\> <\directory\>
	echo Example: gits.sh push origin master ~/projects/clj
	exit 0
}

#if number of args is 0 exit
if [ $# -eq 0 ]
then
	nocommand
fi

if [ "$1" == "--help" ]
then
	help
fi

#if numargs is 1 AND args[0] is a directory then error
if [ $# -eq 1 ] && [ -d $1 ]
then
	nocommand
fi

args=("$@")
LAST_INDEX=$(($# - 1))
#if last arg is not a directory then use the current
if [ ! -d ${args[$LAST_INDEX]} ]
then
	DIR=$(pwd)
	GIT_ARGS=${args[@]}
else
	DIR="${args[$LAST_INDEX]}"
	GIT_ARGS=${args[@]:0:$LAST_INDEX}
fi

#add trailing "/" if not present
LEN=${#DIR}-1
if [ "${DIR:LEN}" != "/" ]
then
	DIR=$DIR"/"
fi

yellow=$(tput setaf 3)
normal=$(tput sgr0)
for dir in $(ls -d $DIR*/)
do
	if [ -d $dir/.git ]
	then
		pushd $dir > /dev/null
		printf '%s\n' "${yellow}${PWD##*/} : - ${normal}"
		git ${GIT_ARGS[@]}
		popd > /dev/null
	fi
done
