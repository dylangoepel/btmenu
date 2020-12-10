all: ~/.local/bin/btmenu

~/.local/bin/btmenu: btmenu.sh
	cp $< $@
	chmod +x $@
