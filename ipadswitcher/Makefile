TARGET := iphone:clang:latest:7.0
ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = iPadSwitcher

iPadSwitcher_FILES = ipsRootListController.m
iPadSwitcher_FRAMEWORKS = UIKit
iPadSwitcher_PRIVATE_FRAMEWORKS = Preferences
iPadSwitcher_INSTALL_PATH = /Library/PreferenceBundles
iPadSwitcher_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
