SHELL := $(CURDIR)/wrapper
NUM_SLOTS ?= 10
P := + @DEBUG=1

ifdef WITHOUT_PLUS
P := $(filter-out +,$(P))
endif

help: ## This help
	@echo -e "galante-make wrapper\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo -e "\nDefault NUM_SLOTS=$(NUM_SLOTS)"
	@echo -e "Define WITHOUT_PLUS to remove '+' sign"

.DEFAULT_GOAL := help

rule_ok: ## Test a valid bash command
	$(P) NUM_SLOTS=$(NUM_SLOTS) echo "rule_ok: NUM_SLOTS=$(NUM_SLOTS)"

rule_error: ## Test a non valid bash command
	$(P) NUM_SLOTS=$(NUM_SLOTS) echo "rule_error: NUM_SLOTS=$(NUM_SLOTS)"; \
		non_existe 666

.PHONY: help rule_ok rule_error
