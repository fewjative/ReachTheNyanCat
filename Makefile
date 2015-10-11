ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = ReachTheNyanCat
ReachTheNyanCat_FILES = Tweak.xm NyanCatController.m
ReachTheNyanCat_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore
ReachTheNyanCat_CFLAGS = -Wno-error
ReachTheNyanCat_LDFLAGS += -Wl,-segalign,4000
export GO_EASY_ON_ME := 1
include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += ReachTheNyanCatSettings
include $(THEOS_MAKE_PATH)/aggregate.mk

before-stage::
	find . -name ".DS_STORE" -delete
after-install::
	install.exec "killall -9 backboardd"
