COMMON_CONF = desktop
COMMON_OVERLAYS = desktop

define root.patched/post
	mkdir -p $O/root.patched/usr/lib/offline-mode/purge-packages.list.d
	cp plan/net $O/root.patched/usr/lib/offline-mode/purge-packages.list.d/
endef

include $(FAB_PATH)/common/mk/turnkey-desktop.mk

