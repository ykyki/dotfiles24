.DEFAULT_GOAL := help

.PHONY: help all clean test $(wildcard test/*)

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

test:
	@echo "TODO"

LOCAL_IMAGE_NAME = d24-local
test/container-local:
	podman build -t $(LOCAL_IMAGE_NAME):latest $@
	podman run -it --rm -v ${PWD}/:/workdir/dotfiles localhost/$(LOCAL_IMAGE_NAME):latest

REMOTE_IMAGE_NAME = d24-remote
test/container-remote:
	podman build --no-cache -t $(REMOTE_IMAGE_NAME):latest $@
	podman run -it --rm localhost/$(REMOTE_IMAGE_NAME):latest