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
XDG_DATA_HOME   := ${HOME}/.local/share
XDG_STATE_HOME  := ${HOME}/.local/state
XDG_CACHE_HOME  := ${HOME}/.cache

.PHONY: base
base: xdg-homes zsh vim

.PHONY: xdg-homes
xdg-homes:
	mkdir -p ${XDG_CONFIG_HOME}
	mkdir -p ${XDG_DATA_HOME}
	mkdir -p ${XDG_STATE_HOME}
	mkdir -p ${XDG_CACHE_HOME}

.PHONY: zsh
ZDOTDIR := ${XDG_CONFIG_HOME}/zsh
zsh:
	mkdir -p ${ZDOTDIR}
	test -L ${HOME}/.zshenv       || ${LN} ${PWD}/zsh/.zshenv           ${HOME}/.zshenv
	test -L ${ZDOTDIR}/.zshrc     || ${LN} ${PWD}/zsh/.zshrc            ${ZDOTDIR}/.zshrc
	test -f ${ZDOTDIR}/.zlogout   || ${CP} ${PWD}/zsh/.zlogout.example  ${ZDOTDIR}/.zlogout
	test -L ${ZDOTDIR}/common.zsh || ${LN} ${PWD}/zsh/common.zsh        ${ZDOTDIR}/common.zsh
	test -f ${ZDOTDIR}/local.zsh  || ${CP} ${PWD}/zsh/local.example.zsh ${ZDOTDIR}/local.zsh
	mkdir -p ${XDG_CONFIG_HOME}/zabrze
	test -L ${XDG_CONFIG_HOME}/zabrze/config.yaml || ${LN} ${PWD}/zsh/zabrze/config.yaml ${XDG_CONFIG_HOME}/zabrze/config.yaml

.PHONY: git
GIT_CONFIG_DIR := ${XDG_CONFIG_HOME}/git
git:
	mkdir -p ${GIT_CONFIG_DIR}
	mkdir -p ${GIT_CONFIG_DIR}/conf.d
	test -L ${GIT_CONFIG_DIR}/config || ${LN} ${PWD}/git/config ${GIT_CONFIG_DIR}/config
	test -L ${GIT_CONFIG_DIR}/ignore || ${LN} ${PWD}/git/ignore ${GIT_CONFIG_DIR}/ignore
	test -f ${GIT_CONFIG_DIR}/conf.d/local.conf || touch ${GIT_CONFIG_DIR}/conf.d/local.conf

.PHONY: tmux
TMUX_CONFIG_DIR := ${XDG_CONFIG_HOME}/tmux
tmux:
	mkdir -p ${TMUX_CONFIG_DIR}
	test -L ${TMUX_CONFIG_DIR}/tmux.conf  || ${LN} ${PWD}/tmux/tmux.conf          ${TMUX_CONFIG_DIR}/tmux.conf
	test -f ${TMUX_CONFIG_DIR}/local.conf || ${CP} ${PWD}/tmux/local.example.conf ${TMUX_CONFIG_DIR}/local.conf

.PHONY: vim
vim:
	test -L ${HOME}/.vimrc || ln -sv ${PWD}/vim/.vimrc ${HOME}/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@# vim +PlugInstall +qall
	vim -es -u ${HOME}/.vimrc +PlugInstall +qall

.PHONY: tig
TIG_CONFIG_DIR := ${XDG_CONFIG_HOME}/tig
tig:
	mkdir -p ${TIG_CONFIG_DIR}
	test -L ${TIG_CONFIG_DIR}/config || ln -sv ${PWD}/tig/.tigrc ${TIG_CONFIG_DIR}/config

.PHONY: idea
idea:
	test -L ${HOME}/.ideavimrc || ln -sv ${PWD}/idea/.ideavimrc ${HOME}/.ideavimrc

.PHONY: alacritty
ALACRITTY_CONFIG_DIR := ${XDG_CONFIG_HOME}/alacritty
alacritty:
	mkdir -p ${ALACRITTY_CONFIG_DIR}
	test -L ${ALACRITTY_CONFIG_DIR}/alacritty.toml || ${LN} ${PWD}/alacritty/alacritty.toml ${ALACRITTY_CONFIG_DIR}/alacritty.toml

.PHONY: ghostty
GHOSTTY_CONFIG_DIR := ${XDG_CONFIG_HOME}/ghostty
ghostty:
	mkdir -p ${GHOSTTY_CONFIG_DIR}
	test -L ${GHOSTTY_CONFIG_DIR}/config || ${LN} ${PWD}/ghostty/config ${GHOSTTY_CONFIG_DIR}/config

.PHONY: nvim clean-nvim
NVIM_APPNAME    := nvim
NVIM_CONFIG_DIR := ${XDG_CONFIG_HOME}/${NVIM_APPNAME}
nvim:
	mkdir -p ${XDG_CONFIG_HOME}
	test -L ${NVIM_CONFIG_DIR} || ${LN} ${PWD}/nvim ${NVIM_CONFIG_DIR}
	nvim --headless "+Lazy! sync" +qa
clean-nvim:
	unlink ${NVIM_CONFIG_DIR}
	rm -rf ${HOME}/.local/share/${NVIM_APPNAME}
	rm -rf ${HOME}/.local/state/${NVIM_APPNAME}

.PHONY: claude
CLAUDE_CONFIG_DIR := ${XDG_CONFIG_HOME}/claude
# CLAUDE_CONFIG_DIR := ${HOME}/.claude
claude:
	mkdir -p ${CLAUDE_CONFIG_DIR}
	test -L ${CLAUDE_CONFIG_DIR}/settings.json || ${LN} ${PWD}/claude/settings.json ${CLAUDE_CONFIG_DIR}/settings.json
	test -L ${CLAUDE_CONFIG_DIR}/CLAUDE.md || ${LN} ${PWD}/claude/CLAUDE.md ${CLAUDE_CONFIG_DIR}/CLAUDE.md

.PHONY: container-local container-remote
USER_NAME := ykyki
IMAGE_NAME := d24-ubuntu
container-local:
	podman build -t ${IMAGE_NAME}:latest test/container
	podman run -it --rm -v ${PWD}/:/home/${USER_NAME}/dotfiles24:ro localhost/${IMAGE_NAME}:latest
container-remote:
	podman build -t ${IMAGE_NAME}:latest test/container
	podman run -it --rm localhost/${IMAGE_NAME}:latest \
	zsh -c 'git clone https://github.com/ykyki/dotfiles24.git && zsh'

