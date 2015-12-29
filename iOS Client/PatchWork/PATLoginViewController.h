//
//  PATLoginViewController.h
//  PatchWork
//
//  Created by Sung Han Kim on 2015. 11. 24..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>

@interface PATLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;

@property (weak, nonatomic) IBOutlet DGTAuthenticateButton *authButton;

@property (nonatomic, copy) NSString *profileID;
@property (weak, nonatomic) IBOutlet UIButton *tempBtn;

- (IBAction)didClick:(id)sender;

@end