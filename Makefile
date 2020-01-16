VERSION = $(shell git rev-parse --verify HEAD)
DIR = $(shell pwd)
NAME = wedding_invitations

PHONY: build
build:
	docker build -t wedding_invitations:$(VERSION) --network host .

PHONY: run
run:
	docker run --network host --name $(NAME) wedding_invitations:$(VERSION)

PHONY: dev
run:
	docker run --network host --name $(NAME) -v $(pwd):/app wedding_invitations:$(VERSION)
