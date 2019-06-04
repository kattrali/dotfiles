TODO_ACTIONS=.config/todo/actions
FISH_CONFIG=.config/fish
BROWSER_CONFIG=.config/webkitten
VIM_TEMPLATES=.vim/templates
CONFIG_FILES=$(FISH_CONFIG)/config.fish .config/redshift.conf \
             .config/todo/config .config/nvim/init.vim \
			 .config/firefox/userChrome.css \
			 $(addprefix $(TODO_ACTIONS)/,$(shell ls $(HOME)/$(TODO_ACTIONS))) \
			 $(addprefix $(VIM_TEMPLATES)/,$(shell ls $(HOME)/$(VIM_TEMPLATES))) \
			 $(subst $(HOME)/,,$(shell ls $(HOME)/$(BROWSER_CONFIG)/{**/,}*.{lua,toml,js,css,html} 2>/dev/null))

FUNCTION_TARGET=.config/fish/functions

DOTFILES=.tmux.conf .vimrc .muttrc .gitconfig .tigrc .vimpagerrc \
		 .newsbeuter/config .newsbeuter/urls .gitignore_global \
		 .chunkwmrc .khdrc .gradle/init.gradle
FUNCTIONS=aliases.fish http.fish pw.fish checkmail.fish \
		  readmail.fish pass.fish fish_prompt.fish tomato.fish \
		  brew-checkout.fish bookkeeping.fish gen-changelog.fish \
		  vl.fish

# Synchronize changes for release
all: function-files $(CONFIG_FILES) $(DOTFILES)

.SECONDARY:

.config/%: $(HOME)/.config/%
	@install -c $(HOME)/.config/$* .config/$*

.vim/%: $(HOME)/.vim/%
	@install -c $(HOME)/.vim/$* .vim/$*

.newsbeuter/%: $(HOME)/.newsbeuter/%
	@install -c $(HOME)/.newsbeuter/$* .newsbeuter/$*

.gradle/%: $(HOME)/.gradle/%
	@install -c $(HOME)/.gradle/$* .gradle/$*

.%: $(HOME)/.%
	@install -c $(HOME)/.$* .$*

.PHONY:

function-files: $(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))
