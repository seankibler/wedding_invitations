VERSION = $(shell git rev-parse --verify HEAD)

PHONY: build
build:
	docker build -t wedding_invitations:$(VERSION) --network host .
