STAGING_HOST=staging-docs.lfe.io
STAGING_PATH=/var/www/lfe/staging-docs/reference-guide

SRC=./
BASE_DIR=$(shell pwd)
PROD_DIR=_book
PROD_PATH=$(BASE_DIR)/$(PROD_DIR)
STAGE_DIR=$(PROD_DIR)
STAGE_PATH=$(BASE_DIR)/$(STAGE_DIR)

default: build

setup:
	sudo npm install gitbook-cli -g
	sudo npm install gitbook-plugin-ga -g

build:
	-mkdir -p $(PROD_DIR)
	gitbook build $(SRC) --output=$(PROD_DIR)

run:
	gitbook serve $(SRC)

staging: build
	git pull origin master && \
	rsync -azP ./$(STAGE_DIR)/* $(STAGING_HOST):$(STAGING_PATH)

publish: build
	-git commit -a && git push origin master
	git subtree push --prefix $(PROD_DIR) origin gh-pages

