BOOTSTRAP_CONFIG=~/Dropbox/Bootstrap
SHELL_CONFIG=~/.config/fish

BOOTSTRAP_TARGET=init
FUNCTION_TARGET=functions

BOOTSTRAP=Makefile Brewfile Pipfile config/weechat.sh
DOTFILES=tmux.conf vimrc muttrc gitconfig
FUNCTIONS=aliases.fish http.fish pw.fish workon.fish checkmail.fish readmail.fish pass.fish
FUNCTION_FILES=$(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))
SHELLRC=$(SHELL_CONFIG)/config.fish

# Synchronize changes for release
all: dotfiles function-files bootstrap-files shell-config

.SECONDARY:

$(BOOTSTRAP_TARGET)/%: $(BOOTSTRAP_CONFIG)/%
	@install -C $(BOOTSTRAP_CONFIG)/$* $(BOOTSTRAP_TARGET)/$*

$(FUNCTION_TARGET)/%: $(SHELL_CONFIG)/functions/%
	@install -C $(SHELL_CONFIG)/functions/$* $(FUNCTION_TARGET)/$*

config.fish: $(SHELLRC)
	@install -C $(SHELLRC) config.fish

$(foreach dot,$(DOTFILES), \
$(dot): $(HOME)/.$(dot) ;\
	@install -C $(HOME)/.$(dot) $(dot);\
)

.PHONY:

function-files: $(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))

dotfiles: $(addprefix $(HOME)/.,$(DOTFILES))

bootstrap-files: $(addprefix $(BOOTSTRAP_TARGET)/,$(BOOTSTRAP))

shell-config: config.fish
