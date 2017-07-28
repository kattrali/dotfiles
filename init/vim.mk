PLUG=$(HOME)/.vim/autoload/plug.vim

all: $(PLUG)

$(PLUG):
	@install -d $(HOME)/.vim/autoload
	@curl -fLo $(HOME)/.vim/autoload/plug.vim  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim -c PlugInstall -c qall
