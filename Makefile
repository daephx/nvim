MAKEFLAGS += --no-print-directory

BANNER = \n \e[38;2;4;116;179m███\e[38;5;239m╗   \e[38;2;4;116;179m██\e[38;5;239m╗\e[38;2;4;116;179m███████\e[38;5;239m╗ \e[38;2;4;116;179m██████\e[38;5;239m╗ \e[38;2;104;161;61m██\e[38;5;239m╗   \e[38;2;104;161;61m██\e[38;5;239m╗\e[38;2;104;161;61m██\e[38;5;239m╗\e[38;2;104;161;61m███\e[38;5;239m╗   \e[38;2;104;161;61m███\e[38;5;239m╗\n \e[38;2;4;104;161m████\e[38;5;238m╗  \e[38;2;4;104;161m██\e[38;5;238m║\e[38;2;4;104;161m██\e[38;5;238m╔════╝\e[38;2;4;104;161m██\e[38;5;238m╔═══\e[38;2;4;104;161m██\e[38;5;238m╗\e[38;2;94;145;55m██\e[38;5;238m║   \e[38;2;94;145;55m██\e[38;5;238m║\e[38;2;94;145;55m██\e[38;5;238m║\e[38;2;94;145;55m████\e[38;5;238m╗ \e[38;2;94;145;55m████\e[38;5;238m║\n \e[38;2;3;93;143m██\e[38;5;237m╔\e[38;2;3;93;143m██\e[38;5;237m╗ \e[38;2;3;93;143m██\e[38;5;237m║\e[38;2;3;93;143m█████\e[38;5;237m╗  \e[38;2;3;93;143m██\e[38;5;237m║   \e[38;2;3;93;143m██\e[38;5;237m║\e[38;2;83;129;49m██\e[38;5;237m║   \e[38;2;83;129;49m██\e[38;5;237m║\e[38;2;83;129;49m██\e[38;5;237m║\e[38;2;83;129;49m██\e[38;5;237m╔\e[38;2;83;129;49m████\e[38;5;237m╔\e[38;2;83;129;49m██\e[38;5;237m║\n \e[38;2;3;81;125m██\e[38;5;236m║╚\e[38;2;3;81;125m██\e[38;5;236m╗\e[38;2;3;81;125m██\e[38;5;236m║\e[38;2;3;81;125m██\e[38;5;236m╔══╝  \e[38;2;3;81;125m██\e[38;5;236m║   \e[38;2;3;81;125m██\e[38;5;236m║╚\e[38;2;73;113;43m██\e[38;5;236m╗ \e[38;2;73;113;43m██\e[38;5;236m╔╝\e[38;2;73;113;43m██\e[38;5;236m║\e[38;2;73;113;43m██\e[38;5;236m║╚\e[38;2;73;113;43m██\e[38;5;236m╔╝\e[38;2;73;113;43m██\e[38;5;236m║\n \e[38;2;2;70;107m██\e[38;5;235m║ ╚\e[38;2;2;70;107m████\e[38;5;235m║\e[38;2;2;70;107m███████\e[38;5;235m╗╚\e[38;2;2;70;107m██████\e[38;5;235m╔╝ ╚\e[38;2;62;97;37m████\e[38;5;235m╔╝ \e[38;2;62;97;37m██\e[38;5;235m║\e[38;2;62;97;37m██\e[38;5;235m║ ╚═╝ \e[38;2;62;97;37m██\e[38;5;235m║\n \e[38;5;234m╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝\e[0m
VERSION = $(shell nvim --version | head -n 1 | cut -d ' ' -f2)

ROOT_DIR := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))
TEMP_DIR := ${ROOT_DIR}/.build
XDG_DIRS := 'cache' 'config' 'data' 'state'

all: build

help: ## Display Makefile commands
	@echo "$(BANNER)"
	@$(eval VERSION_WIDTH=$(shell echo -n "--- [ $(VERSION) ] ---" | wc -c))
	@$(eval PADDING=$(shell echo "(51 - $(VERSION_WIDTH)) / 2" | bc))
	@printf "%${PADDING}s\e[90m--- [ \e[95m$(VERSION)\e[90m ] ---\e[0m\n\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf " \033[36m%-7s \033[90m- \033[0m%s\n", $$1, $$2}' ${MAKEFILE_LIST}
	@echo

confirm:
	@echo -n "Do you wish to continue? [y/N]: " && read ans && [ $${ans:-N} = y ]

build: ## Create temporary instance of neovim
ifdef NVIM
	$(error NVIM is already active, please close in order to create temporary instance.)
endif
	@mkdir -vp $(addprefix ${TEMP_DIR}/,${XDG_DIRS})
	@ln -sTf "${ROOT_DIR}" "${TEMP_DIR}/config/nvim" 2>/dev/null || true
	@export MYVIMRC="${ROOT_DIR}/init.lua" && \
	export XDG_CACHE_HOME="${TEMP_DIR}/cache" && \
	export XDG_CONFIG_HOME="${TEMP_DIR}/config" && \
	export XDG_DATA_HOME="${TEMP_DIR}/data" && \
	export XDG_STATE_HOME="${TEMP_DIR}/state" && \
	nvim # Launch nvim with patched xdg variables

clean: ## Remove temporary environment
	@echo "Cleaning up build directories..."
	@echo
	@echo "The following directory will be deleted: \"$(TEMP_DIR)\""
	@echo
	@echo "These files are created during \`make build\` and are used to set up a temporary Neovim instance."
	@echo "This allows testing configuration changes in isolated environments, such as cloned repositories or worktrees."
	@echo
	@$(MAKE) confirm # Will prompt the user for confirmation
	@rm -rfv "$(TEMP_DIR)"

lint: ## Run style checker and linter: stylua/selene
	@stylua --check after/ lua/ init.lua
	@selene after/ lua/ init.lua

format: ## Run formatter: stylua
	@stylua -v after/ lua/ init.lua

