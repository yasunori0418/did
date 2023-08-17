.DEFAULT_GOAL := help

.PHONY := help
# INFO: 参考サイト - https://postd.cc/auto-documented-makefile/
help: ## subcommand list and description.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Initialize my favorite environment container.
	@docker compose up -d

clean: ## Remove all container information.
	@docker compose down --rmi all --remove-orphans --volumes

reset: ## clean & init
	@make clean
	@make init

start: ## docker compose start
	@docker compose start

stop: ## docker compose stop
	@docker compose stop

zsh: ## get inside the container
	@docker compose exec did zsh

ps: ## docker compose ps
	@docker compose ps -a
