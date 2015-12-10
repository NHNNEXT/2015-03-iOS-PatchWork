
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#include "PATSwirlGestureRecognizer.h"
#include "PATWheelTouchUpGestureRecognizer.h"
#include "PATWheelTouchDownGestureRecognizer.h"

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface PATWheelViewController : UIViewController <PATSwirlGestureRecognizerDelegate, PATWheelTouchUpGestureRecognizerDelegate, PATWheelTouchDownGestureRecognizerDelegate, UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet UIView *controlsView;
@property (strong, nonatomic) IBOutlet UIImageView *knob;
@property (strong, nonatomic) IBOutlet UILabel *position;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *emotionInWheel;


@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;

@property (nonatomic, copy) NSString *profileID;

@property (nonatomic, strong) NSString *authBy;
 
@end
