.DEFAULT_GOAL := help
MAKEFLAGS += --always-make
BRANCH := main

# INFO: 参考サイト - https://postd.cc/auto-documented-makefile/
help: ## subcommand list and description.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

start: ## docker compose start
	@docker compose start

stop: ## docker compose stop
	@docker compose stop

ps: ## docker compose ps
	@docker compose ps -a

build: ## build did image
	@docker build --rm=true --force-rm=true --no-cache=true --pull=true \
	--tag="ghcr.io/yasunori0418/did:latest" .

zsh: ## container start and attach with zsh
	@make start
	@docker compose exec did zsh

init: ## Initialize my favorite environment container.
	@docker compose up -d
	@sleep 5
	@docker compose exec did git clone -b $(BRANCH) https://github.com/yasunori0418/dotfiles.git
	@docker compose exec -w /root/dotfiles did make init

PHONY := clean
clean: ## Remove all container information.
	@docker compose down --rmi all --volumes

reset: ## clean & init
	@make clean
	@make init

PHONY := test
test: ## did container setup check.
	@make init
	@echo "did setup no problem!"
	@make clean

PHONY := all
