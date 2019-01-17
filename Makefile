build:
	GOOS=linux GOARCH=amd64 go build main.go
	npm run build

# こういう書き方もある
# 依存ファイルは存在していたらパスされる
# build: main static/js/bundle.js

# main:
# 	GOOS=linux GOARCH=amd64 go build main.go

# static/js/bundle.js:
# 	npm run build

zip: build
	tar zcvf main.tar.gz main templates/ static/

upload:
	scp -i ~/.ssh/$(PEM_NAME).pem main.tar.gz ec2-user@$(AWS_IP_ADRESS).compute.amazonaws.com:~/app
	scp -i ~/.ssh/$(PEM_NAME).pem provisioning/Makefile ec2-user@$(AWS_IP_ADRESS).compute.amazonaws.com:~/app

ssh: # \の前にスペースないと怒られる
	ssh -i ~/.ssh/$(PEM_NAME).pem ec2-user@$(AWS_IP_ADRESS).compute.amazonaws.com \
	cd app/ \&\& \
	make start

clean:
	rm main
	rm main.tar.gz

deploy: zip # make deploy前にzipを実行
	make upload
	make clean
	make ssh
