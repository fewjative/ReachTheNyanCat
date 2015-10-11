ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = ReachTheNyanCatSettings
ReachTheNyanCatSettings_INSTALL_PATH = /Library/Application Support/ReachTheNyanCatSettings/

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp ReachTheNyanCatSettings.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ReachTheNyanCatSettings.plist$(ECHO_END)
	$(ECHO_NOTHING)cp *.png $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(ECHO_END)

include $(THEOS_MAKE_PATH)/aggregate.mk
