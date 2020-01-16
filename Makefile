VERSION = $(shell git rev-parse --verify HEAD)
NAME = wedding_invitations

PHONY: build
build:
	docker build -t wedding_invitations:$(VERSION) --network host .

PHONY: run
run:
	docker run --network host --name $(NAME) wedding_invitations:$(VERSION)

PHONY: dev
dev:
	docker run --network host --name $(NAME) -v $(shell pwd):/app wedding_invitations:$(VERSION)

PHONY: push
push:
	docker push quay.io/seankibler/wedding_invitations:$(VERSION)
