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
    [_tempBtn setHidden:YES];
    
    UIButton *myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    //myLoginButton.backgroundColor=[UIColor darkGrayColor];
    myLoginButton.frame=CGRectMake(69,402,180,40);
    //[myLoginButton setTitle: @"Login with Facebook" forState: UIControlStateNormal];
    
    UIImage *btnImage = [UIImage imageNamed:@"LOGIN_facebook login.png"];
    [myLoginButton setImage:btnImage forState:UIControlStateNormal];
    
    [myLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:myLoginButton];
    
    CGRect btnFrame = _loginButton.frame;
    btnFrame.origin.x = 20;
    btnFrame.origin.y = 431;
    _loginButton.frame = btnFrame;
    _loginButton.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:_loginButton];
    
    
    //[self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    _loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    /*
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
    */
    
    /*
    DGTAuthenticationConfiguration *configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsEmail];
    configuration.title = @"Login to Digits";
    Digits *digits = [Digits sharedInstance];
    [digits authenticateWithViewController:nil configuration:configuration completion:^(DGTSession *session, NSError *error) {
        // Inspect session to access the email address of the user
    }];
    */
    
    [[Digits sharedInstance] logOut];
    
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
             [parameters setValue:@"id,name,email" forKey:@"fields"];
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          NSMutableDictionary *dictData = [[NSMutableDictionary alloc] init];
                          
                          [dictData setObject:result[@"email"] forKey:@"email"];
                          
                          NSLog(@"fetched user:%@", result[@"email"]);
                          
                          NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:5000/login"]];
                          [request setHTTPMethod:@"POST"];
                          [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                          [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
                          
                          NSError *error;
                          NSData *postData = [NSJSONSerialization dataWithJSONObject:dictData options:0 error:&error];
                          [request setHTTPBody:postData];
                          
                          NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                          NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
                          
                          NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                          }];
                          
                          [postDataTask resume];
                          
                          [self performSegueWithIdentifier: @"btn" sender: self];
                      }
                  }];
             }
             

         }
     }];
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
    /*
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSMutableDictionary *dictData = [[NSMutableDictionary alloc] init];
                 
                 [dictData setObject:result[@"email"] forKey:@"email"];
                 
                 NSLog(@"fetched user:%@", result[@"email"]);
                 
                 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:5000/login"]];
                 [request setHTTPMethod:@"POST"];
                 [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                 [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
                 
                 NSError *error;
                 NSData *postData = [NSJSONSerialization dataWithJSONObject:dictData options:0 error:&error];
                 [request setHTTPBody:postData];
                 
                 NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                 NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
                 
                 NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                 }];
                 
                 [postDataTask resume];
                 
                 [self performSegueWithIdentifier: @"btn" sender: self];
              }
         }];
    }
     */
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

@end
