STAGING_HOST=staging-docs.lfe.io
STAGING_PATH=/var/www/lfe/staging-docs/reference-guide

SRC=./
BASE_DIR=$(shell pwd)
PROD_DIR=_book
PROD_PATH=$(BASE_DIR)/$(PROD_DIR)
STAGE_DIR=$(PROD_DIR)
STAGE_PATH=$(BASE_DIR)/$(STAGE_DIR)

OS := $(shell uname -s)
ifeq ($(OS),Linux)
	NPM_INSTALL=sudo apt-get install npm
	NPM=/usr/local/bin/npm
	NPM_CMD=sudo $(NPM)
	GB_CMD=sudo gitbook
endif
ifeq ($(OS),Darwin)
	NPM_INSTALL=brew install npm
	NPM=/usr/local/bin/npm
	NPM_CMD=npm
	GB_CMD=gitbook
endif

default: build

$(NPM):
	$(NPM_INSTALL)

setup: $(NPM)
	$(NPM_CMD) install gitbook-cli -g
	$(NPM_CMD) install gitbook-plugin-ga -g
	$(GB_CMD) install

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

push-mirror:
	git push gitlab --all
	git push gitlab --tags

push-main:
	git push origin --all
	git push origin --tags

push: push-mirror push-main
