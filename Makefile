BOOTSTRAP_CONFIG=~/Dropbox/Bootstrap
FISH_CONFIG=.config/fish
CONFIG_FILES=$(FISH_CONFIG)/config.fish .config/redshift.conf

BOOTSTRAP_TARGET=init
FUNCTION_TARGET=.config/fish/functions

BOOTSTRAP=Makefile Brewfile Pipfile config/weechat.sh
DOTFILES=.tmux.conf .vimrc .muttrc .gitconfig .tigrc .vimpagerrc \
		 .newsbeuter/config .newsbeuter/urls .amethyst
FUNCTIONS=aliases.fish http.fish pw.fish workon.fish checkmail.fish \
		  readmail.fish pass.fish fish_prompt.fish tomato.fish

# Synchronize changes for release
all: bootstrap-files function-files $(CONFIG_FILES) $(DOTFILES)

.SECONDARY:

$(BOOTSTRAP_TARGET)/%: $(BOOTSTRAP_CONFIG)/%
	@install -C $(BOOTSTRAP_CONFIG)/$* $(BOOTSTRAP_TARGET)/$*

.config/%: $(HOME)/.config/%
	@install -c $(HOME)/.config/$* .config/$*

.newsbeuter/%: $(HOME)/.newsbeuter/%
	@install -c $(HOME)/.newsbeuter/$* .newsbeuter/$*

.%: $(HOME)/.%
	@install -c $(HOME)/.$* .$*

.PHONY:

function-files: $(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))

bootstrap-files: $(addprefix $(BOOTSTRAP_TARGET)/,$(BOOTSTRAP))

