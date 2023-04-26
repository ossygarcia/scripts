#!/usr/bin/env bash
date=$(date)
user=$(whoami)
dir=$(pwd)
echo "WELCOME TO MY PC"
echo "WHAT IS YOUR NAME?"
read -r name
if [ "$name" ];
    then
echo "Hello $name,today is $date, your computer name is $user and you are working on $dir directory"
write.ul "/home/israel/Downloads"
else
echo "It's Empty!"
fi

