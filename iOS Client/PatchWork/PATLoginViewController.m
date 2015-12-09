//
//  PATLoginViewController.m
//  PatchWork
//
//  Created by Sung Han Kim on 2015. 11. 24..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PATLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Fabric/Fabric.h>
#import <DigitsKit/DigitsKit.h>
#import "PATWheelViewController.h"

@interface PATLoginViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation PATLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    //loginButton.center = self.view.center;
    //CGRect btnFrame = _loginButton.frame;
    //btnFrame.origin.x = 137;
    //btnFrame.origin.y = 391;
    //_loginButton.frame = btnFrame;
    //[self.view addSubview:_loginButton];
    
    //[self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    _loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    DGTAuthenticateButton *authButton = [[DGTAuthenticateButton alloc] init];
    authButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        if (session.userID) {
            // TODO: associate the session userID with your user model
            NSString *msg = [NSString stringWithFormat:@"Phone number: %@", session.phoneNumber];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are logged in!"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else if (error) {
            NSLog(@"Authentication error: %@", error.localizedDescription);
        }
    }];
    
    CGRect btnFrameTwitter = authButton.frame;
    btnFrameTwitter.origin.x = 20;
    btnFrameTwitter.origin.y = 458;
    authButton.frame = btnFrameTwitter;
    [self.view addSubview:authButton];
    
    
    DGTAuthenticationConfiguration *configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsEmail];
    configuration.title = @"Login to Digits";
    Digits *digits = [Digits sharedInstance];
    [digits authenticateWithViewController:nil configuration:configuration completion:^(DGTSession *session, NSError *error) {
        // Inspect session to access the email address of the user
    }];
    
    [[Digits sharedInstance] logOut];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}


-(void)loginViewFetchedUserInfo:(FBSDKLoginButton *)loginView user:(id)user{
    NSLog(@"%@", user);
    self.profilePicture.profileID = user;
    self.lblUsername.text = user;
    self.lblEmail.text = [user objectForKey:@"email"];
}

-(void)loginViewShowingLoggedOutUser:(FBSDKLoginButton *)loginView{
    self.lblLoginStatus.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
}


-(void)loginView:(FBSDKLoginButton *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}


- (void)didTapButton {
    [[Digits sharedInstance] authenticateWithCompletion:^(DGTSession *session, NSError *error) {
        // Inspect session/error objects
    }];
 
    Digits *digits = [Digits sharedInstance];
    DGTAuthenticationConfiguration *configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsDefaultOptionMask];
        configuration.phoneNumber = @"+82";
    [digits authenticateWithViewController:nil configuration:configuration completion:^(DGTSession *newSession, NSError *error){
        // Country selector will be set to Spain
    }];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue identifier: %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"facebookBtn"]){
        //[FBSDKAppEvents activateApp];
        
        /*
        NSString *facebookAuthApiURL = @"server_api_address";
        // Other data will be propagating
        NSURL *postURL = [NSURL URLWithString:facebookAuthApiURL];
        NSError __autoreleasing *errorRequest;
        NSHTTPURLResponse __autoreleasing *responseRequest;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:postURL];
        NSInputStream *inputData;
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBodyStream:inputData];

         */
        PATWheelViewController *nextViewController = [segue destinationViewController];
        nextViewController.authBy = @"facebook";
        NSLog(@"Before segue: %@", nextViewController.authBy);
        
    } else if ([[segue identifier] isEqualToString:@"twitterBtn"]){
        PATWheelViewController *nextViewController = [segue destinationViewController];
        nextViewController.authBy = @"twitter";
        
        /*
        DGTAuthenticateButton *authButton;
        authButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
            if (session.userID) {
                // TODO: associate the session userID with your user model
                NSString *msg = [NSString stringWithFormat:@"Phone number: %@", session.phoneNumber];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are logged in!"
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            } else if (error) {
                NSLog(@"Authentication error: %@", error.localizedDescription);
            }
        }];
        
        authButton.center = self.view.center;
        [self.view addSubview:authButton];
        
        
        DGTAuthenticationConfiguration *configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsEmail];
        configuration.title = @"Login to Digits";
        Digits *digits = [Digits sharedInstance];
        [digits authenticateWithViewController:nil configuration:configuration completion:^(DGTSession *session, NSError *error) {
            // Inspect session to access the email address of the user
        }];
         */

    }
    
}


@end
