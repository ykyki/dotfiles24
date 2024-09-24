.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help          Show this help message"
	@echo "  ...           (TODO)"

.PHONY: zsh
ZSHMY_PATH=${HOME}/.zshmy
zsh:
	test -L ${HOME}/.zshrc || ln -sv ${PWD}/zsh/.zshrc ${HOME}/.zshrc
	test -f ${HOME}/.zlogout || cp ${PWD}/zsh/.zlogout.example ${HOME}/.zlogout
	test -d ${ZSHMY_PATH} || mkdir -p ${ZSHMY_PATH}
	test -L ${ZSHMY_PATH}/common.zsh || ln -sv ${PWD}/zsh/common.zsh ${ZSHMY_PATH}/common.zsh
	test -f ${ZSHMY_PATH}/local.zsh || cp ${PWD}/zsh/local.example.zsh ${ZSHMY_PATH}/local.zsh

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

