# pkg-remove

## how to use

- you can download the shell script "pkg-remove.sh
" and excute it.
 - command line is 
 - `sudo sh /yourDownloadPath/pkg-remove.sh` 
 - or you can just type `sudo sh ` and drag the sh.file to yor Mac terminal.
 - you must have sudo permission to remove pkg, if just search pkg infomation, you don't need sudo permission.

- 你也可以下載中文腳本「 	移除pkg.sh」後，直接在終端機執行
 - `sudo sh 把腳本拖拉到你的終端機`
 - 你必須是系統管理員才能移除pkg，但是一般查詢pkg資訊，不需要sudo

- here is the gif demo    

![](https://raw.githubusercontent.com/iamrToday/album/master/pkg-remove/demoGif.gif)

## feature

- use "number code" to control pkgs list on you Mac
	- 利用數字編號來操作Mac的pkg記錄
- make pkg install-timestamp to human readable format
	- pkg安裝時間記錄，用可讀方式展現
- transfer the whole pkg name form "a.b.c.d" to "a b c d", automatically copied the keyword on your mac clipboard, you can JUST PASTE (use HOTKEY command V) on the google search bar or URL column.(if you just search "a.b.c.d", browser will think it is a url address)
	- 把pkg全名轉成可搜尋關鍵字，你可以直接用熱鍵cmd V去貼在google搜尋框或是網址列。因為預設你貼上pkg全名a.b.c.d，瀏覽器會把它當成網址。
- 中文使用者可以下載「移除pkg.sh」，裡面互動模式全部中文   

## is there GUI version?
no,you can use [UninstallPKG](https://www.corecode.io/uninstallpkg/), I don't want to Reinventing the wheel. 

你可以直接使用付費軟體[UninstallPKG](https://www.corecode.io/uninstallpkg/)，它已經寫很好了

## FAQ

- why not list the com.apple.pkg?
	- if you don't know what the pkg is, DO NOT TRY to remove com.apple.pkg. Murphy tell us "If there is any way to do it wrong, he will"
- 為什麼不顯示蘋果的pkg？ 
	- 因為我怕你什麼都不知道就亂移除，有些pkg是系統的玩意兒

##  License
MIT 
