setup:
	./setup/setup.sh
	./setup/install_brave.sh
	./setup/install_syncthing.sh

links:
	./setup/soft_linker.sh

ENCO: setup
	./setup/setup_ENCO.sh
