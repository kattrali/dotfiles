define mirror
$(subst $(HOME)/,,$(wildcard $(HOME)/$1))
endef
CONFIG_FILES=.config/fish/config.fish \
			 .config/firefox/userChrome.css \
			 $(call mirror,.vim/autoload/*) \
			 $(call mirror,.vim/templates/*) \
			 $(call mirror,.config/nvim/*) \
			 $(call mirror,.config/nvim/UltiSnips/*) \
			 $(subst $(HOME)/,,$(shell ls $(HOME)/.config/webkitten/{**/,}*.{lua,toml,js,css,html} 2>/dev/null))

DOTFILES=.tmux.conf .vimrc .muttrc .gitconfig .tigrc .vimpagerrc \
		 .gitignore_global .chunkwmrc .khdrc

FUNCTIONS=aliases.fish http.fish pw.fish checkmail.fish \
		  readmail.fish pass.fish fish_prompt.fish tomato.fish \
		  brew-checkout.fish bookkeeping.fish gen-changelog.fish \
		  vl.fish xcodenv.fish

COMPLETIONS=$(subst $(HOME)/,,$(shell ls $(HOME)/.config/fish/completions))

# Synchronize changes for release
all: $(addprefix .config/fish/functions/,$(FUNCTIONS)) $(COMPLETIONS) $(CONFIG_FILES) $(DOTFILES)

.SECONDARY:

.vim/%: $(HOME)/.vim/%
	@$(shell mkdir -p $(@D))
	@install -c $(HOME)/$@ $@

.%: $(HOME)/.%
	@$(shell mkdir -p $(@D))
	@install -c $(HOME)/.$* .$*
