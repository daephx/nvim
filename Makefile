MAKEFLAGS += --no-print-directory

BANNER = \n \e[38;5;21m███\e[38;5;239m╗   \e[38;5;21m██\e[38;5;239m╗\e[38;5;21m███████\e[38;5;239m╗ \e[38;5;21m██████\e[38;5;239m╗ \e[38;5;46m██\e[38;5;239m╗   \e[38;5;46m██\e[38;5;239m╗\e[38;5;46m██\e[38;5;239m╗\e[38;5;46m███\e[38;5;239m╗   \e[38;5;46m███\e[38;5;239m╗\n \e[38;5;20m████\e[38;5;238m╗  \e[38;5;20m██\e[38;5;238m║\e[38;5;20m██\e[38;5;238m╔════╝\e[38;5;20m██\e[38;5;238m╔═══\e[38;5;20m██\e[38;5;238m╗\e[38;5;40m██\e[38;5;238m║   \e[38;5;40m██\e[38;5;238m║\e[38;5;40m██\e[38;5;238m║\e[38;5;40m████\e[38;5;238m╗ \e[38;5;40m████\e[38;5;238m║\n \e[38;5;19m██\e[38;5;237m╔\e[38;5;19m██\e[38;5;237m╗ \e[38;5;19m██\e[38;5;237m║\e[38;5;19m█████\e[38;5;237m╗  \e[38;5;19m██\e[38;5;237m║   \e[38;5;19m██\e[38;5;237m║\e[38;5;34m██\e[38;5;237m║   \e[38;5;34m██\e[38;5;237m║\e[38;5;34m██\e[38;5;237m║\e[38;5;34m██\e[38;5;237m╔\e[38;5;34m████\e[38;5;237m╔\e[38;5;34m██\e[38;5;237m║\n \e[38;5;18m██\e[38;5;236m║╚\e[38;5;18m██\e[38;5;236m╗\e[38;5;18m██\e[38;5;236m║\e[38;5;18m██\e[38;5;236m╔══╝  \e[38;5;18m██\e[38;5;236m║   \e[38;5;18m██\e[38;5;236m║╚\e[38;5;28m██\e[38;5;236m╗ \e[38;5;28m██\e[38;5;236m╔╝\e[38;5;28m██\e[38;5;236m║\e[38;5;28m██\e[38;5;236m║╚\e[38;5;28m██\e[38;5;236m╔╝\e[38;5;28m██\e[38;5;236m║\n \e[38;5;17m██\e[38;5;235m║ ╚\e[38;5;17m████\e[38;5;235m║\e[38;5;17m███████\e[38;5;235m╗╚\e[38;5;17m██████\e[38;5;235m╔╝ ╚\e[38;5;22m████\e[38;5;235m╔╝ \e[38;5;22m██\e[38;5;235m║\e[38;5;22m██\e[38;5;235m║ ╚═╝ \e[38;5;22m██\e[38;5;235m║\n \e[38;5;234m╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝\e[0m
VERSION = $(shell nvim --version | head -n 1 | cut -d ' ' -f2)

ROOT_DIR := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))
TEMP_DIR := ${ROOT_DIR}/.home
XDG_DIRS := '.cache' '.config' '.local' '.local/share'

all: banner help

help: ## Display Makefile commands
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf " \033[36m%-10s \033[90m- \033[0m%s\n", $$1, $$2}' ${MAKEFILE_LIST}
	@echo

confirm:
	@echo -n "Do you wish to continue? [y/N]: " && read ans && [ $${ans:-N} = y ]

banner:
	@echo "$(BANNER)"
	@printf "\e[90m%-10s --- [ ${VERSION} ] --- \e[0m\n"
	@echo

build: ## Create a temporary xdg environment
	@mkdir -vp $(addprefix ${TEMP_DIR}/,${XDG_DIRS})
	@ln -sTf "${ROOT_DIR}" "${TEMP_DIR}/.config/nvim" 2>/dev/null || true

clean: confirm ## Remove temporary environment
	@echo "Removing build directories..."
	@rm -rfv "$(TEMP_DIR)"

run: build ## Run temporary instance of neovim
ifdef NVIM
	$(error NVIM is already active, please close in order to create temporary instance.)
endif
	@echo "Starting temporary neovim instance..."
	@sleep 1.2 2>/dev/null || true
	@export MYVIMRC="${ROOT_DIR}/init.lua" && \
	export XDG_CACHE_HOME="${TEMP_DIR}/.cache" && \
	export XDG_CONFIG_HOME="${TEMP_DIR}/.config" && \
	export XDG_DATA_HOME="${TEMP_DIR}/.local/share" && \
	export XDG_LOCAL_HOME="${TEMP_DIR}/.local" && \
	export XDG_STATE_HOME="${TEMP_DIR}/.local/state" && \
	nvim # Launch nvim with patched xdg_dirs

format: ## Run formatter: stylua
	@stylua after/ lua/ init.lua

lint: ## Run linter: selene
	@selene after/ lua/ init.lua
