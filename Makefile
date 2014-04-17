COMMON_CONF = desktop
COMMON_OVERLAYS = desktop

define root.build/pre
	fab-chroot $O/root.build --script conf.d/preseeds
endef

define root.patched/post
	cp plan/net $O/root.patched/usr/lib/bitkey.d/purge-packages.list
endef

include $(FAB_PATH)/common/mk/turnkey-desktop.mk

