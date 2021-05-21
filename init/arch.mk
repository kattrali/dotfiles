
.PHONY: home-layout packages weechat vim
vim:
	@$(MAKE) -f vim.mk

weechat:
	@$(MAKE) -f weechat.mk

home-layout:
	@mkdir -p ~/tmp/{code,downloads,go,screenshots}
	@mkdir -p ~/mail/{cur,new,tmp}
	@mkdir -p ~/bin
	@mkdir -p ~/projects
	@mkdir -p ~/.config/vim/{bundle,autoload,tmp}

packages:
	@cat init/arch/Pacfile | xargs pacman -S --needed --noconfirm
	@bash init/arch/aur-install.sh
