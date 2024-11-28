.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help          Show this help message"
	@echo "  ...           (TODO)"

LN := ln -sv
CP := cp -v

XDG_CONFIG_HOME := ${HOME}/.config
ZDOTDIR         := ${XDG_CONFIG_HOME}/zsh

.PHONY: zsh
zsh:
	mkdir -p ${ZDOTDIR}
	test -L ${HOME}/.zshenv       || $(LN) ${PWD}/zsh/.zshenv           ${HOME}/.zshenv
	test -L ${ZDOTDIR}/.zshrc     || $(LN) ${PWD}/zsh/.zshrc            ${ZDOTDIR}/.zshrc
	test -f ${ZDOTDIR}/.zlogout   || $(CP) ${PWD}/zsh/.zlogout.example  ${ZDOTDIR}/.zlogout
	test -L ${ZDOTDIR}/common.zsh || $(LN) ${PWD}/zsh/common.zsh        ${ZDOTDIR}/common.zsh
	test -f ${ZDOTDIR}/local.zsh  || $(CP) ${PWD}/zsh/local.example.zsh ${ZDOTDIR}/local.zsh

.PHONY: git
git:
	test -L ${HOME}/.gitconfig || ln -sv ${PWD}/git/.gitconfig ${HOME}/.gitconfig
	test -d ${HOME}/.config/git || mkdir -p ${HOME}/.config/git
	test -L ${HOME}/.config/git/ignore || ln -sv ${PWD}/git/.gitignore_global ${HOME}/.config/git/ignore

.PHONY: tmux
tmux:
	test -L ${HOME}/.tmux.conf || ln -sv ${PWD}/tmux/.tmux.conf ${HOME}/.tmux.conf

.PHONY: vim
vim:
	test -L ${HOME}/.vimrc || ln -sv ${PWD}/vim/.vimrc ${HOME}/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@# vim +PlugInstall +qall
	vim -es -u ${HOME}/.vimrc +PlugInstall +qall

.PHONY: nvim clean-nvim
NVIM_APPNAME := nvim
NVIM_CONFIG_DIR := ${HOME}/.config/$(NVIM_APPNAME)
nvim:
	mkdir -p ${HOME}/.config
	test -L $(NVIM_CONFIG_DIR) || ln -sv ${PWD}/nvim $(NVIM_CONFIG_DIR)
	nvim --headless "+Lazy! sync" +qa
clean-nvim:
	unlink $(NVIM_CONFIG_DIR)
	rm -rf ${HOME}/.local/share/$(NVIM_APPNAME)
	rm -rf ${HOME}/.local/state/$(NVIM_APPNAME)

.PHONY: tig
tig:
	test -L ${HOME}/.tigrc || ln -sv ${PWD}/tig/.tigrc ${HOME}/.tigrc

.PHONY: idea
idea:
	test -L ${HOME}/.ideavimrc || ln -sv ${PWD}/idea/.ideavimrc ${HOME}/.ideavimrc

.PHONY: alacritty
ALACRITTY_PATH := ${HOME}/.config/alacritty/alacritty.toml
alacritty:
	mkdir -p ${HOME}/.config/alacritty
	test -L ${ALACRITTY_PATH} || ln -sv ${PWD}/alacritty/alacritty.toml ${ALACRITTY_PATH}

.PHONY: container-local container-remote
USER_NAME := ykyki
IMAGE_NAME := d24-ubuntu
container-local:
	podman build -t $(IMAGE_NAME):latest test/container
	podman run -it --rm -v ${PWD}/:/home/${USER_NAME}/dotfiles24:ro localhost/$(IMAGE_NAME):latest
container-remote:
	podman build -t $(IMAGE_NAME):latest test/container
	podman run -it --rm localhost/$(IMAGE_NAME):latest \
	zsh -c 'git clone https://github.com/ykyki/dotfiles24.git && zsh'

