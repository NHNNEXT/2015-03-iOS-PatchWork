//
//  PATLoginViewController.m
//  PatchWork
//
//  Created by Sung Han Kim on 2015. 11. 24..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface PATLoginViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation PATLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];

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


-(void)loginViewFetchedUserInfo:(FBSDKLoginButton *)loginView user:(userid<Open Graph Test User>)user{
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

@end
