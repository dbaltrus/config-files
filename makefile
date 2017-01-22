DIR=$(shell pwd)
BACKUP=$(DIR)/backup

all: cpvim cpxmonad

backup:
	mkdir $(BACKUP)

cpvim: backup
	mv ~/.vimrc $(BACKUP)/
	cp $(DIR)/vim/.vimrc ~/

cpxmonad: backup
	mv -f ~/.xmonad/* $(BACKUP)/
	cp -r $(DIR)/xmonad/.xmonad ~/

