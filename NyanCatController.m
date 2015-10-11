#import "NyanCatController.h"
#import <QuartzCore/QuartzCore.h>

#define kBundlePath @"/Library/Application Support/ReachTheNyanCatSettings/ReachTheNyanCatSettings.bundle"

@implementation NyanCatController

//Shared Instance
+(instancetype)sharedInstance {
	static dispatch_once_t pred;
	static NyanCatController *shared = nil;
	 
	dispatch_once(&pred, ^{
		shared = [[NyanCatController alloc] init];
	});
	return shared;
}

//Widget setup
-(void)setBackgroundWindow:(SBWindow*)window {
	backgroundWindow = window;
}

-(void)setupWidget {

	if (backgroundWindow) {
	
		NSBundle *bundle = [[[NSBundle alloc] initWithPath:kBundlePath] autorelease];
		NSString *imagePath = [bundle pathForResource:@"Portrait-Nyan-1" ofType:@"png"];
		nyanCatImageview = [[UIImageView alloc] initWithFrame:backgroundWindow.bounds];
		nyanCatImageview.image = [UIImage imageWithContentsOfFile:imagePath];
		nyanCatImageview.contentMode = UIViewContentModeScaleAspectFit;
	    nyanCatImageview.clipsToBounds = NO;
	    
	    NSMutableArray *array = [NSMutableArray array];
	    for (int i = 1; i < 13; i++) {
	    	NSString *imagePath = [bundle pathForResource:[NSString stringWithFormat:@"Portrait-Nyan-%d", i] ofType:@"png"];
	        [array addObject:[UIImage imageWithContentsOfFile:imagePath]];
	    }

	    nyanCatImageview.animationImages = array;
	    nyanCatImageview.animationDuration = 1.0;
	    nyanCatImageview.animationRepeatCount = 0;
	    [nyanCatImageview startAnimating];
	    
	    self.view.clipsToBounds = NO;
		[backgroundWindow addSubview:nyanCatImageview];
	}
}

//Bye bye widget
-(void)deconstructWidget {

	if (nyanCatImageview) {
		[nyanCatImageview removeFromSuperview];
		[nyanCatImageview release];
		nyanCatImageview = nil;
	}
}

@end