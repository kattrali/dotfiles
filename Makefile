BOOTSTRAP_CONFIG=~/Dropbox/Bootstrap
SHELL_CONFIG=~/.config/fish

BOOTSTRAP_TARGET=init
FUNCTION_TARGET=fish/functions

BOOTSTRAP=Makefile Brewfile Pipfile config/weechat.sh
DOTFILES=.tmux.conf .vimrc .muttrc .gitconfig .tigrc .vimpagerrc \
		 .newsbeuter/config .newsbeuter/urls
FUNCTIONS=aliases.fish http.fish pw.fish workon.fish checkmail.fish \
	  readmail.fish pass.fish fish_prompt.fish
SHELLRC=$(SHELL_CONFIG)/config.fish

# Synchronize changes for release
all: dotfiles bootstrap-files shell-config

.SECONDARY:

$(BOOTSTRAP_TARGET)/%: $(BOOTSTRAP_CONFIG)/%
	@install -C $(BOOTSTRAP_CONFIG)/$* $(BOOTSTRAP_TARGET)/$*

$(FUNCTION_TARGET)/%: $(SHELL_CONFIG)/functions/%
	@install -C $(SHELL_CONFIG)/functions/$* $(FUNCTION_TARGET)/$*

fish/config.fish: $(SHELLRC)
	@install -C $(SHELLRC) fish/config.fish

.newsbeuter/%: $(HOME)/.newsbeuter/%
	@install -c $(HOME)/.newsbeuter/$* .newsbeuter/$*

.%: $(HOME)/.%
	@install -c $(HOME)/.$* .$*

.PHONY:

function-files: $(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))

dotfiles: $(DOTFILES)

bootstrap-files: $(addprefix $(BOOTSTRAP_TARGET)/,$(BOOTSTRAP))

shell-config: fish/config.fish function-files

