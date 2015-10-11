#import <UIKit/UIKit.h>

@interface SBWindow : UIWindow
@end

@interface NyanCatController : UIViewController {
	
	SBWindow *backgroundWindow;
	UIImageView *nyanCatImageview;
}

+(instancetype)sharedInstance;
-(void)setBackgroundWindow:(SBWindow*)window;
-(void)setupWidget;
-(void)deconstructWidget;

@end