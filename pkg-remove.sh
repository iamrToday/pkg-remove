#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#=================================================
#	Description: remove pkg on Mac
#	Version: 1.0.0
#	Author: rtoday
#=================================================
echo "-------------------------------------------------------"
echo "this script can just REMOVE ONE PKG AT ONE TIME on you mac."
echo "sometimes you install big software like virtualbox, it will automatically install patch."
echo "remember to execute this script again!"
echo 
echo "this script will not show apple's pkg, if you want to know more about apple's pkg."
echo "please insert below command line on terminal."
echo 
echo "pkgutil --pkgs | grep 'com.apple.pkg'"
echo "-------------------------------------------------------"
echo "1. I want to give some keyword to search pkg."
echo "2. I want to list all pkgs I had installed (without com.apple.pkg)."
read -p "please insert 1 or 2: " listPkg
if [ "${listPkg}" == "1" ]; then
	read -p "case insensitive, please insert your keyword: " softwareKeyword
	echo "-------------------------------------------------------"
	pkgutil --pkgs  | grep -in ${softwareKeyword}
elif [ "${listPkg}" == "2" ]; then
	pkgutil --pkgs  | grep -vn 'com.apple.pkg'
else
	echo insert error, Bye
	exit 0
fi

echo "-------------------------------------------------------"
echo "the list was formatted with    code number:whole pkg name"
echo "Now, show you more infomation about this pkg on your Mac."
read -p "please inset 'the code number': " softwareNum
echo "-------------------------------------------------------"
software=`pkgutil --pkgs | sed -n "${softwareNum}p"`
echo "Here is the pkg's information on your Mac."
pkgutil --pkg-info ${software}
#transfer timestamp
echo "-------------------------------------------------------"
echo "you install this pkg on below time"
installTime=`pkgutil --pkg-info ${software} | grep 'install-time:' | awk '{print $2}'`
date -r ${installTime}

#make "a.b.c.d" to "a b c d" 
#generate keyword to clipboard, if search a.b.c.d, google will think it is a web address
echo "------------------------------------------------------------------------------"
echo "1. I don't know what this pkg is, please generate the keyword for me to search."
echo "2. No, please take me to the remove command."
read -p "your choice: " isWebKeyWord
if [ ${isWebKeyWord} == "1" ]; then
	pkgutil --pkgs  | grep ${software} | awk 'BEGIN {FS="."} {print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7}' | pbcopy
	echo "----------------------------------------------------"
	echo "this script had already copied the pkg whole name keyword on your Mac clipboard,"
	echo "please go to your browser , and JUST PASTE the keyword to search more infomation. "
	echo "(you can use HOTKEY command+V)"
fi

echo  "----------------------------------------------------------------------------"
echo  "sure you had ALREADY KNOW WHAT THIS PKG IS, and turn that application off" 
read -p "are you sure you want to remove this pks?[y/n]: " yn
if [ "${yn}" == "Y" -o "${yn}" == "y" ]; then
	#determine the install path
	installPath=`pkgutil --pkg-info ${software} | grep 'location:' | awk '{print $2}'`
	cd /${installPath}
	#start uninstall
	pkgutil --only-files --files ${software} | tr '\n' '\0' | xargs -n 1 -0 rm -if
	pkgutil --only-dirs --files ${software} | tr '\n' '\0' | xargs -n 1 -0 rm -ifr
	sudo pkgutil --forget ${software}
	cd
	echo "remove success, Bye"
	exit 0
else
	echo "I DO NOT remove any pkg, Bye."
	exit 0
fi
