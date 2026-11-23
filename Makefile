VIMDIR=$(DESTDIR)/usr/share/vim
ADDONS=${VIMDIR}/addons

all:

install:
	mkdir -pv ${ADDONS}/after/ftplugin ${ADDONS}/after/syntax ${ADDONS}/doc
	cp -v after/ftplugin/markdown.vim ${ADDONS}/after/ftplugin/markdown.vim
	cp -v after/syntax/markdown.vim ${ADDONS}/after/syntax/markdown.vim
	cp -v doc/simple-markdown.txt ${ADDONS}/doc/simple-markdown.txt

test: build/tabular build/vader.vim
	test/run-tests.sh

update: build/tabular build/vader.vim
	cd build/tabular && git pull
	cd build/vader.vim && git pull

build/tabular: | build
	git clone https://github.com/godlygeek/tabular build/tabular

build/vader.vim: | build
	git clone https://github.com/junegunn/vader.vim build/vader.vim

build:
	mkdir build

.PHONY: all install test update
