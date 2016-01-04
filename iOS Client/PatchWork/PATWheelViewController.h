
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "PATSwirlGestureRecognizer.h"
#import "PATWheelTouchUpGestureRecognizer.h"
#import "PATWheelTouchDownGestureRecognizer.h"
#import "PATMapContainerViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>

@interface PATWheelViewController : UIViewController <PATSwirlGestureRecognizerDelegate, PATWheelTouchUpGestureRecognizerDelegate, PATWheelTouchDownGestureRecognizerDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *detectingLocationView;
@property (strong, nonatomic) IBOutlet UIImageView *locationServiceErrorView;
@property (strong, nonatomic) IBOutlet UIButton *emotionPosShowButton;
@property (strong, nonatomic) IBOutlet UIView *emotionPoses;



@property (strong, nonatomic) IBOutlet UIView *controlsView;
@property (strong, nonatomic) IBOutlet UIImageView *knob;
@property (strong, nonatomic) IBOutlet UILabel *position;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *emotionInWheel;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet UIButton *doneArrow;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;

@property (nonatomic, copy) NSString *profileID;

@property (nonatomic, strong) NSString *authBy;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) PATMapContainerViewController* mapContainerViewController;

@property CGFloat touchPosition;

// 휠 돌리는 중에는 emotionPosShowButton 마스킹 기능을 막기 위해 다음 변수를 둠.
@property BOOL wheelTouchChecker;
@property BOOL emotionPosTouchChecker;


- (void)didDoneButtonTouched:(id)sender;
- (IBAction)emotionPosShow:(id)sender forEvent:(UIEvent *)event;
- (IBAction)emotionPosHide:(id)sender forEvent:(UIEvent *)event;



 
@end
