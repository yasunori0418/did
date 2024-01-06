.DEFAULT_GOAL := help
dotfiles_branch = main

.PHONY := help
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

zsh: ## container start and attach with zsh
	@make start
	@docker compose exec did zsh

init: ## Initialize my favorite environment container.
	@docker compose build --no-cache
	@docker compose up -d
	@sleep 5
	@docker compose exec did git clone -b $(dotfiles_branch) https://github.com/yasunori0418/dotfiles.git
	@sleep 8
	@docker compose exec -w /root/dotfiles did make init
	@sleep 3
	-@docker compose exec -w /root/dotfiles did make nvim-night
	@docker compose exec did zsh -c 'mise install --yes'
	@make zsh

clean: ## Remove all container information.
	@docker compose down --rmi all --remove-orphans --volumes

reset: ## clean & init
	@make clean
	@make init
