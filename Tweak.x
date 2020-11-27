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

%hook SBAppSwitcherSettings
- (void)setGridSwitcherPageScale:(double)arg1 {
    switch(cardStyle){
        case 0:
            %orig(0.30);
            break;
        case 1:
            %orig(0.38);
            break;
        case 2:
            %orig(0.4);
            break;
        case 3:
            %orig(0.42);
            break;
    }
}

- (void)setGridSwitcherHorizontalInterpageSpacingPortrait:(double)arg1 {
    %orig(horizSpacingPort);
}

- (void)setGridSwitcherVerticalNaturalSpacingPortrait:(double)arg1 {
    %orig(vertSpacingPort);
}

- (void)setGridSwitcherHorizontalInterpageSpacingLandscape:(double)arg1 {
    %orig(horizSpacingLand);
}

- (void)setGridSwitcherVerticalNaturalSpacingLandscape:(double)arg1 {
    %orig(vertSpacingLand);
}

- (void)setSwitcherStyle:(long long)arg1 {
    if(isEnabled)
		%orig(2);
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
