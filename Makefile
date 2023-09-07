.DEFAULT_GOAL := help

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

zsh: ## get inside the container
	@docker compose exec did zsh

init: ## Initialize my favorite environment container.
	@docker compose build
	@docker compose up -d
	@sleep 5
	@docker compose exec did git clone https://github.com/yasunori0418/dotfiles.git
	@sleep 8
	@docker compose exec -w /root/dotfiles did make init
	@docker compose exec -w /root/dotfiles did make pyenv-get
	-@docker compose exec did zsh -c 'rtx install --yes'
	@make zsh

clean: ## Remove all container information.
	@docker compose down --rmi all --remove-orphans --volumes

reset: ## clean & init
	@make clean
	@make init
