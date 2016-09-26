WEECHAT_CFG=$(HOME)/.weechat
WEECHAT_PYCFG=$(WEECHAT_CFG)/python/autoload
WEECHAT_PERLCFG=$(WEECHAT_CFG)/perl/autoload

all: $(WEECHAT_PYCFG)/wee_slack.py \
	 $(WEECHAT_PYCFG)/weemoji.py \
	 $(WEECHAT_PERLCFG)/buffers.pl

$(WEECHAT_PYCFG)/wee_slack.py:
	@install -d $(WEECHAT_PYCFG)
	@cd $(WEECHAT_PYCFG); \
		wget https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py

$(WEECHAT_PYCFG)/weemoji.py:
	@install -d $(WEECHAT_PYCFG)
	@cd $(WEECHAT_PYCFG); \
		wget https://raw.githubusercontent.com/kattrali/weemoji/master/weemoji.py

$(WEECHAT_PERLCFG)/buffers.pl:
	@install -d $(WEECHAT_PERLCFG)
	@cd $(WEECHAT_PERLCFG); \
		wget https://weechat.org/files/scripts/buffers.pl
