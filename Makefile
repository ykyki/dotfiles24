.DEFAULT_GOAL := help

.PHONY: help all clean test $(wildcard test/*) git

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help          Show this help message"
	@echo "  all           Run all the setup steps"
	@echo "  clean         Run all the cleanup steps"
	@echo "  test          Run the tests"

all:
	@echo "TODO"

all-install:
	@echo "TODO"

clean:
	@echo "TODO"

git:
	test -L ${HOME}/.gitconfig || ln -sv ${PWD}/git/.gitconfig ${HOME}/.gitconfig
	test -d ${HOME}/.config/git || mkdir -p ${HOME}/.config/git
	test -L ${HOME}/.config/git/ignore || ln -sv ${PWD}/git/.gitignore_global ${HOME}/.config/git/ignore

clean-git:
	! test -L ${HOME}/.gitconfig || unlink ${HOME}/.gitconfig
	! test -L ${HOME}/.config/git/ignore || unlink ${HOME}/.config/git/ignore
	! test -d ${HOME}/.config/git || rmdir ${HOME}/.config/git

test:
	@echo "TODO"

USERNAME = ykyki
LOCAL_IMAGE_NAME = d24-local
test/container-local:
	podman build -t $(LOCAL_IMAGE_NAME):latest $@
	podman run -it --rm -v ${PWD}/:/home/${USERNAME}/dotfiles24 localhost/$(LOCAL_IMAGE_NAME):latest

REMOTE_IMAGE_NAME = d24-remote
test/container-remote:
	podman build --no-cache -t $(REMOTE_IMAGE_NAME):latest $@
	podman run -it --rm localhost/$(REMOTE_IMAGE_NAME):latest