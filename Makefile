TODO_ACTIONS=.config/todo/actions
FISH_CONFIG=.config/fish
BROWSER_CONFIG=.config/webkitten
CONFIG_FILES=$(FISH_CONFIG)/config.fish .config/redshift.conf \
             .config/todo/config \
			 $(addprefix $(TODO_ACTIONS)/,$(shell ls $(HOME)/$(TODO_ACTIONS))) \
			 $(subst $(HOME)/,,$(shell ls $(HOME)/$(BROWSER_CONFIG)/{**/,}*.{lua,toml,js,css,html} 2>/dev/null))

FUNCTION_TARGET=.config/fish/functions

DOTFILES=.tmux.conf .vimrc .muttrc .gitconfig .tigrc .vimpagerrc \
		 .newsbeuter/config .newsbeuter/urls .gitignore_global
FUNCTIONS=aliases.fish http.fish pw.fish workon.fish checkmail.fish \
		  readmail.fish pass.fish fish_prompt.fish tomato.fish \
		  brew-checkout.fish bookkeeping.fish

# Synchronize changes for release
all: function-files $(CONFIG_FILES) $(DOTFILES)

.SECONDARY:

.config/%: $(HOME)/.config/%
	@install -c $(HOME)/.config/$* .config/$*

.newsbeuter/%: $(HOME)/.newsbeuter/%
	@install -c $(HOME)/.newsbeuter/$* .newsbeuter/$*

.%: $(HOME)/.%
	@install -c $(HOME)/.$* .$*

.PHONY:

function-files: $(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))
