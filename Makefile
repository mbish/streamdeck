ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

default:
	cd cmd/streamdeck && go build -o $(ROOT_DIR)/streamdeck

update_docs:
	curl -i 'https://proxy.golang.org/github.com/!luzifer/streamdeck/@v/master.info'
