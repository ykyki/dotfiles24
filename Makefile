.DEFAULT_GOAL := help

.PHONY: help all clean test

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help          Show this help message"
	@echo "  all           Run all the setup steps"

all:
	@echo "TODO"

all-setup:
	@echo "TODO"

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

.PHONY: container-local container-remote
USER_NAME = ykyki
IMAGE_NAME = d24-ubuntu
container-local:
	podman build -t $(IMAGE_NAME):latest test/container
	podman run -it --rm -v ${PWD}/:/home/${USER_NAME}/dotfiles24:ro localhost/$(IMAGE_NAME):latest
container-remote:
	podman build -t $(IMAGE_NAME):latest test/container
	podman run -it --rm localhost/$(IMAGE_NAME):latest \
	zsh -c 'git clone https://github.com/ykyki/dotfiles24.git && zsh'
