#import <Foundation/Foundation.h>

NSString *const domainString = @"com.dpkg.ipadswitcher";

static bool isEnabled;
static int vertSpacingPort;
static int cardStyle;
static int horizSpacingPort;
static int vertSpacingLand;
static int horizSpacingLand;

void ReloadPrefs () {

	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:domainString];

	isEnabled = [([prefs objectForKey:@"isEnabled"] ?: @(YES)) boolValue];
	cardStyle = [([prefs objectForKey:@"cardStyle"] ?: @(0.4)) intValue];
	vertSpacingPort = [([prefs objectForKey:@"vertSpacingPort"] ?: @(42)) intValue];
	horizSpacingPort = [([prefs objectForKey:@"horizSpacingPort"] ?: @(25.5)) intValue];
	vertSpacingLand = [([prefs objectForKey:@"vertSpacingLand"] ?: @(38)) intValue];
	horizSpacingLand = [([prefs objectForKey:@"horizSpacingLand"] ?: @(11.6)) intValue];

}

%hook SBGridSwitcherPersonality
- (double)_gridSwitcherPageScale {
    return %orig;
}
%end

%hook SBAppSwitcherSettings
- (void)setGridSwitcherPageScale:(double)arg1 {
	 if (cardStyle == 0) {
			arg1 = 0.30;
			%orig;
	}else if (cardStyle == 1) {
			arg1 = 0.38;
			%orig;
	}else if (cardStyle == 2) {
			arg1 = 0.4;
			%orig;
	}else if (cardStyle == 3) {
			arg1 = 0.42;
			%orig;
	}
}

- (double)gridSwitcherPageScale {
    return %orig;
}

- (void)setGridSwitcherHorizontalInterpageSpacingPortrait:(double)arg1 {
    arg1 = horizSpacingPort;
    %orig;
}

- (void)setGridSwitcherVerticalNaturalSpacingPortrait:(double)arg1 {
    arg1 = vertSpacingPort;
    %orig;
}

- (double)gridSwitcherHorizontalInterpageSpacingPortrait {
    return %orig;
}

- (double)gridSwitcherVerticalNaturalSpacingPortrait {
    return %orig;
}

- (void)setGridSwitcherHorizontalInterpageSpacingLandscape:(double)arg1 {
    arg1 = horizSpacingLand;
    %orig;
}

- (void)setGridSwitcherVerticalNaturalSpacingLandscape:(double)arg1 {
    arg1 = vertSpacingLand;
    %orig;
}

- (double)gridSwitcherHorizontalInterpageSpacingLandscape {
    return %orig;
}

- (double)gridSwitcherVerticalNaturalSpacingLandscape {
    return %orig;
}

- (void)setSwitcherStyle:(long long)arg1 {
	if (isEnabled) {
    arg1 = 2;
    %orig;
  }
}

%end

%ctor {
	ReloadPrefs();
	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		(CFNotificationCallback)ReloadPrefs,
		CFSTR("com.dpkg.ipadswitcher.settingschanged"),
		NULL,
		CFNotificationSuspensionBehaviorDeliverImmediately
	);
	%init;
}
