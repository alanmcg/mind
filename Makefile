# Install mind.sh and mindreader.sh

ifneq ($(shell id -u), 0)
else
$(error "It is not required to install this script as root. Run 'make install' as a regular user.")
endif

install:
	touch ~/.journal.md
	chmod 600 ~/.journal.md
	mkdir -p ~/.local/bin ~/.local/share/icons ~/.local/share/applications
	cp mind.sh ~/.local/bin/mind
	cp mindreader.sh ~/.local/bin/mindreader
	chmod +x ~/.local/bin/mind
	chmod +x ~/.local/bin/mindreader
	cp images/mind.png ~/.local/share/icons/mind.png
	cp images/mindreader.png ~/.local/share/icons/mindreader.png
	sed 's/USERNAME/$(shell whoami)/g' share/mind.desktop > ~/.local/share/applications/mind.desktop
	sed 's/USERNAME/$(shell whoami)/g' share/mindreader.desktop > ~/.local/share/applications/mindreader.desktop
	update-desktop-database ~/.local/share/applications
	###
	# Installed mind and mindreader, the journal file ~/.journal.md was created if it did not exist.
	###


uninstall:
	rm ~/.local/bin/mind
	rm ~/.local/bin/mindreader
	rm ~/.local/share/icons/mind.png
	rm ~/.local/share/icons/mindreader.png
	rm ~/.local/share/applications/mind.desktop
	rm ~/.local/share/applications/mindreader.desktop
	update-desktop-database ~/.local/share/applications
	###
	# Uninstalled mind and mindreader, the journal file ~/.journal.md was not removed.
	# I hope you enjoyed this tool.
	###
