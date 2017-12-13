SHELL := /bin/bash
RED    := \033[0;31m
GREEN  := \033[0;32m
CYAN   := \033[0;36m
YELLOW := \033[1;33m
NC     := \033[0m # No Color

IMPORT_TIME := $(shell /bin/date "+%s")

usage:
	@printf "${YELLOW}make server				${GREEN}Build Ubuntu Server Virtualbox VM${NC}\n"
	@printf "${YELLOW}make desktop				${GREEN}Build Ubuntu Desktop Virtualbox VM${NC}\n"
	@printf "${YELLOW}make import_server			${GREEN}Import Ubuntu Server VM into VirtualBox${NC}\n"
	@printf "${YELLOW}make import_desktop			${GREEN}Import Ubuntu Desktop VM into VirtualBox${NC}\n"
	@printf "${YELLOW}make clean			 	${GREEN}Clean all generated VM instances${NC}\n"

clean:
	@printf "${YELLOW}Removing all legacy builds${NC}\n"
	@rm -rf output-ubuntu1710-virtualbox-iso
	@rm -rf output-ubuntu1710-desktop-virtualbox-iso

server: clean
	@printf "${YELLOW}Building Ubuntu Server Virtualbox${NC}\n"
	packer build -only=virtualbox-iso -var-file=ubuntu1710.json ubuntu.json

desktop: clean
	@printf "${YELLOW}Building Ubuntu Desktop Virtualbox${NC}\n"
	packer build -only=virtualbox-iso -var-file=ubuntu1710-desktop.json ubuntu.json

import_server:
	@printf "${YELLOW}Attempting to import the latest server built locally${NC}\n"
	@test -f output-ubuntu1710-virtualbox-iso/ubuntu1710.ovf || printf "${RED}Server has not been built, run 'make server'${NC}\n"
	vboxmanage import output-ubuntu1710-virtualbox-iso/ubuntu1710.ovf --vsys 0 --vmname ubuntu1710-${IMPORT_TIME}
	vboxmanage modifyvm "ubuntu1710-${IMPORT_TIME}" --natpf1 "guestssh,tcp,,2200,,22"
	@printf "${GREEN}Successfully imported ubuntu1710-${IMPORT_TIME}\n"
	@printf "Once it is running, you can SSH to it via 'ssh ubuntu@127.0.0.1 -p 2200 -o StrictHostKeyChecking=no' with password 'ubuntu'${NC}\n"

import_desktop:
	@printf "${YELLOW}Attempting to import the latest desktop build locally${NC}\n"
	@test -f output-ubuntu1710-desktop-virtualbox-iso/ubuntu1710-desktop.ovf || printf "\n${RED}Desktop has not been built, run 'make desktop'${NC}\n"
	vboxmanage import output-ubuntu1710-desktop-virtualbox-iso/ubuntu1710-desktop.ovf --vsys 0 --vmname ubuntu1710-desktop-${IMPORT_TIME}
	vboxmanage modifyvm "ubuntu1710-desktop-${IMPORT_TIME}" --natpf1 "guestssh,tcp,,2222,,22"
	@printf "${GREEN}Successfully imported ubuntu1710-desktop-${IMPORT_TIME}\n"
	@printf "Once it is running, you can SSH to it via 'ssh ubuntu@127.0.0.1 -p 2222 -o StrictHostKeyChecking=no' with password 'ubuntu'${NC}\n"

.PHONY: usage clean server desktop import_server import_desktop
.DEFAULT_GOAL := usage
