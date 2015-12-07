//
//  MapContainerViewController.m
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 21..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATMapContainerViewController.h"

@implementation PATMapContainerViewController

-(void) viewDidLoad {
	
	[super viewDidLoad];
	
	// Set googleMapVC, sideMenuVC and SettingsVC as properties, and add googleMapVC as a Subview
	self.mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATGoogleMapViewController"];
	self.sideMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSideMenuViewController"];
	self.settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSettingsViewController"];
	
	[self addChildViewController:self.mapViewController];
	self.mapViewController.view.frame = self.view.bounds;
	[self.view addSubview:self.mapViewController.view];
	self.mapViewController.delegate = self;
	[self.mapViewController didMoveToParentViewController:self];
	
	self.PATStartPositionOfSideMenu = self.view.bounds.size.width*(-1.0f);
	[self addChildViewController:self.sideMenuViewController];
	self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	[self.view addSubview:self.sideMenuViewController.view];
	[self.sideMenuViewController didMoveToParentViewController:self];
	
	self.PATStartPositionOfSettings = self.view.bounds.size.width*(-1.0f);
	[self addChildViewController:self.settingsViewController];
	self.settingsViewController.view.frame = CGRectMake(self.PATStartPositionOfSettings, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	[self.view addSubview:self.settingsViewController.view];
	[self.settingsViewController didMoveToParentViewController:self];
}


-(void) PATShowSideMenu {
	
	self.PATStartPositionOfSideMenu = 0;
	
	[UIView animateWithDuration:0.5
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
					 }
					 completion:nil];
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];

	if (point.x >= self.view.bounds.size.width*0.6f) {
			
		self.PATStartPositionOfSideMenu = self.view.bounds.size.width*(-1.0f);
		[UIView animateWithDuration:0.5
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseOut
						 animations:^{
							 self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
						 }
						 completion:nil];
	}
}



@end