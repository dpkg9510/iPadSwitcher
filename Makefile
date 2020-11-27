TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e
export SDKVERSION = 13.4

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iPadSwitcher

iPadSwitcher_FILES = Tweak.x
iPadSwitcher_CFLAGS = -fobjc-arc

SUBPROJECTS += ipadswitcher

include $(THEOS)/makefiles/tweak.mk
include $(THEOS)/makefiles/aggregate.mk
