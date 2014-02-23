COMMON_CONF = desktop
COMMON_OVERLAYS = desktop

define root.patched/post
	cp plan/net $O/root.patched/usr/lib/bluestone.d/purge-packages.list
endef

include $(FAB_PATH)/common/mk/turnkey-desktop.mk

