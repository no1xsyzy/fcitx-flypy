.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

.PHONY: all
all: flypy.mb

flypy.mb: flypy.mb.txt
	@txt2mb flypy.mb.txt flypy.mb
	@echo code table generated

flypy.mb.txt: flypy.head flypy.body
	@cat flypy.head flypy.body > flypy.mb.txt

.PHONY: install
install: _install_icon _install_conf _install_mb
	@echo All installed

.PHONY: _install_icon
_install_icon: /usr/share/fcitx/imicon/flypy.png
/usr/share/fcitx/imicon/flypy.png: flypy.png
	@cp flypy.png /usr/share/fcitx/imicon/flypy.png
	@echo pic installed

.PHONY: _install_conf
_install_conf: /usr/share/fcitx/table/flypy.conf
/usr/share/fcitx/table/flypy.conf: flypy.conf
	@cp flypy.conf /usr/share/fcitx/table/flypy.conf
	@echo config installed

.PHONY: _install_mb
_install_mb: /usr/share/fcitx/table/flypy.mb
/usr/share/fcitx/table/flypy.mb: flypy.mb
	@cp flypy.mb /usr/share/fcitx/table/flypy.mb
	@echo code table installed

.PHONY: clean
clean:
	@rm -rf flypy.mb.txt

.PHONY: cleanall
cleanall: clean
	@rm -rf flypy.mb

.PHONY: uninstall
uninstall:
	$(RM) /usr/share/fcitx/imicon/flypy.png
	$(RM) /usr/share/fcitx/table/flypy.conf
	$(RM) /usr/share/fcitx/table/flypy.mb
