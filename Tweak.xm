#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import "NyanCatController.h"

#define kBundlePath @"/Library/Application Support/ReachTheNyanCatSettings/ReachTheNyanCatSettings.bundle"

static BOOL enabled = NO;

// for iOS9
%hook SBMainWorkspace

-(void)handleReachabilityModeActivated {
	%orig;
	if (enabled && [%c(SBReachabilityManager) reachabilitySupported]) {
		NSLog(@"[RTNC] Setting reachability window.");
		SBWindow *backgroundView = MSHookIvar<SBWindow*>(self,"_reachabilityEffectWindow");
		[[NyanCatController sharedInstance] setBackgroundWindow:backgroundView];
		[[NyanCatController sharedInstance] setupWidget];
		NSLog(@"[RTNC] Creation and addition success.");
	}
}

-(void)handleReachabilityModeDeactivated {
	%orig;

	int64_t delay = 1.0;
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
	dispatch_after(time, dispatch_get_main_queue(), ^(void) {
			[[NyanCatController sharedInstance] deconstructWidget];
	});

}

-(void)handleCancelReachabilityRecognizer:(id)arg{
	%orig;

	int64_t delay = 1.0;
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
	dispatch_after(time, dispatch_get_main_queue(), ^(void) {
			[[NyanCatController sharedInstance] deconstructWidget];
	});
}

%end

%hook SBWorkspace

-(void)handleReachabilityModeActivated {
	%orig;
	if (enabled && [%c(SBReachabilityManager) reachabilitySupported]) {
		NSLog(@"[RTNC] Setting reachability window.");
		SBWindow *backgroundView = MSHookIvar<SBWindow*>(self,"_reachabilityEffectWindow");
		[[NyanCatController sharedInstance] setBackgroundWindow:backgroundView];
		[[NyanCatController sharedInstance] setupWidget];
		NSLog(@"[RTNC] Creation and addition success.");
	}
}

-(void)handleReachabilityModeDeactivated {
	%orig;

	int64_t delay = 1.0;
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
	dispatch_after(time, dispatch_get_main_queue(), ^(void) {
			[[NyanCatController sharedInstance] deconstructWidget];
	});

}

-(void)handleCancelReachabilityRecognizer:(id)arg{
	%orig;

	int64_t delay = 1.0;
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
	dispatch_after(time, dispatch_get_main_queue(), ^(void) {
			[[NyanCatController sharedInstance] deconstructWidget];
	});
}

%end

static void loadPrefs() 
{
	NSLog(@"Loading ReachTheNyanCat prefs");
    CFPreferencesAppSynchronize(CFSTR("com.joshdoctors.reachthenyancat"));

    enabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.joshdoctors.reachthenyancat")) ? NO : [(id)CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.joshdoctors.reachthenyancat")) boolValue];
    if (enabled) {
        NSLog(@"[ReachTheNyanCat] We are enabled");
    } else {
        NSLog(@"[ReachTheNyanCat] We are NOT enabled");
    }
}

%ctor
{
	NSLog(@"Loading ReachTheNyanCat");
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                NULL,
                                (CFNotificationCallback)loadPrefs,
                                CFSTR("com.joshdoctors.reachthenyancat/settingschanged"),
                                NULL,
                                CFNotificationSuspensionBehaviorDeliverImmediately);
	loadPrefs();
}