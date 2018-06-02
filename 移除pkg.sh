#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#=================================================
#	Description: remove pkg on Mac
#	Version: 1.0.0
#	Author: rtoday
#=================================================
echo "這腳本，一次只能移除一個pkg，有時候你安裝一個大型軟體，比如virtualbox會自動安裝patch，所以記得同系列軟體要一起移除，必須再執行一次這腳本"
echo "這腳本，預設不顯示蘋果系列pkg，有需要請下達這指令查詢"
echo "pkgutil --pkgs | grep 'com.apple.pkg'"
echo
read -p "1.我要查詢pkg關鍵字 2.我要列出所有pkg(不含蘋果系列pkg)，請輸入1或2: " listPkg
if [ "${listPkg}" == "1" ]; then
	read -p "不在乎大小寫，關鍵字為 " softwareKeyword
	pkgutil --pkgs  | grep -in ${softwareKeyword}
elif [ "${listPkg}" == "2" ]; then
	pkgutil --pkgs  | grep -vn 'com.apple.pkg'
else
	echo 輸入錯誤，結束
	exit 0
fi


echo 這個列表最前面，我已經加上編號
read -p "接下來要列出安裝資訊，輸入你想查詢的「編號數字」: " softwareNum
#這裡就一定要把cpm.apple.pkg「不忽略」，因為行號有算到cpm.apple.pkg
echo 你選擇
#原本sed都用單引號，因為現在有變數要取用，改成雙引號
software=`pkgutil --pkgs | sed -n "${softwareNum}p"`
echo 以下是軟體的安裝資訊
pkgutil --pkg-info ${software}
#給予客戶安裝日期
echo 軟體安裝日期是
installTime=`pkgutil --pkg-info ${software} | grep 'install-time:' | awk '{print $2}'`
date -r ${installTime}

#因為直接google搜尋"a.b.c.d"會變成網址路徑，所以要把.改成空白，變成"a b c d" 
echo 
echo 1.我不知道這pkg是什麼，請幫我去掉.變成空白，產生搜尋關鍵字
echo 2.不用了，進入移除指令
read -p "你的選擇 " isWebKeyWord
if [ ${isWebKeyWord} == "1" ]; then
	pkgutil --pkgs  | grep ${software} | awk 'BEGIN {FS="."} {print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7}' | pbcopy
	echo 已經把關鍵字寫入你的mac剪貼簿，
	echo 請到瀏覽器搜尋框或網址列，直接貼上（熱鍵cmd v）
fi

echo 
echo  "先確認你已經知道這pkg是什麼，而且「完全關閉」該軟體" 
read -p "你確定要移除軟體嗎？[y/n]: " yn
if [ "${yn}" == "Y" -o "${yn}" == "y" ]; then
	#判斷安裝路徑
	installPath=`pkgutil --pkg-info ${software} | grep 'location:' | awk '{print $2}'`
	cd /${installPath}
	#開始移除
	pkgutil --only-files --files ${software} | tr '\n' '\0' | xargs -n 1 -0 rm -if
	pkgutil --only-dirs --files ${software} | tr '\n' '\0' | xargs -n 1 -0 rm -ifr
	sudo pkgutil --forget ${software}
	cd
	echo 移除成功
	exit 0
else
	echo "我「沒有」移除軟體，再見"
	exit 0
fi
