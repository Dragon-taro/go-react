unzip:
	tar zxvf main.tar.gz
	rm main.tar.gz

nginx:
	sudo service nginx start

# うまくバックグラウンド起動にできないから出力先を変更
start: unzip nginx
	./main >> /dev/null &
