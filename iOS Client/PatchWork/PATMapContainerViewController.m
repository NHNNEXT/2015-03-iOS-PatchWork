//
//  MapContainerViewController.m
//  PathchWork
//
//  Created by BgKim on 2015. 11. 21..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATMapContainerViewController.h"

@implementation PATMapContainerViewController

-(void) viewDidLoad {
	
	[super viewDidLoad];
	
	// Set googleMapVC, sideMenuVC, settingsVC and searchLocationVC as properties, and add googleMapVC as a Subview
	self.mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATGoogleMapViewController"];
	self.sideMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSideMenuViewController"];
	self.settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSettingsViewController"];
	self.searchLocationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSearchLocationViewController"];
	
	[self addChildViewController:self.mapViewController];
	self.mapViewController.view.frame = self.view.bounds;
	[self.view addSubview:self.mapViewController.view];
	self.mapViewController.delegate = self;
	[self.mapViewController didMoveToParentViewController:self];
	
	self.PATStartPositionOfSideMenu = self.view.bounds.size.width*(-1.0f);
	[self addChildViewController:self.sideMenuViewController];
	self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	[self.view addSubview:self.sideMenuViewController.view];
	self.sideMenuViewController.delegate = self;
	[self.sideMenuViewController didMoveToParentViewController:self];
	
	self.PATStartPositionOfSettings = self.view.bounds.size.width*(-1.0f);
	[self addChildViewController:self.settingsViewController];
	self.settingsViewController.view.frame = CGRectMake(self.PATStartPositionOfSettings, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	[self.view addSubview:self.settingsViewController.view];
	[self.settingsViewController didMoveToParentViewController:self];
	
	self.PATStartPositionOfSearchLocation = self.view.bounds.size.width*(-1.0f);
	[self addChildViewController:self.searchLocationViewController];
	self.searchLocationViewController.willShowKeyboard = NO;
	self.searchLocationViewController.view.frame = CGRectMake(self.PATStartPositionOfSearchLocation, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	self.searchLocationViewController.delegate = self;
	[self.view addSubview:self.searchLocationViewController.view];
	[self.searchLocationViewController didMoveToParentViewController:self];
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


-(void) PATShowSetting {

	self.PATStartPositionOfSideMenu = self.view.bounds.size.width*(-1.0f);
	self.PATStartPositionOfSettings = 0;
	
	self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	self.settingsViewController.view.frame = CGRectMake(self.PATStartPositionOfSettings, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	
}


-(void) PATShowEmotionView {
	[self performSegueWithIdentifier:@"toEmotionSegue" sender:self];
}


- (void) PATShowTextField {
	
	self.PATStartPositionOfSideMenu = self.view.bounds.size.width*(-1.0f);
	self.PATStartPositionOfSearchLocation = 0;
	
	[UIView animateWithDuration:0.5
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
					 }
					 completion:^(BOOL finished){
						 self.searchLocationViewController.view.frame = CGRectMake(self.PATStartPositionOfSearchLocation, 0, self.view.bounds.size.width, self.view.bounds.size.height);
						 self.searchLocationViewController.willShowKeyboard = YES;
					 }];
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];
	
	if (point.x >= self.view.bounds.size.width*0.6f) {
		
		if (self.PATStartPositionOfSideMenu >= -0.01) {
			self.PATStartPositionOfSideMenu = self.view.bounds.size.width*(-1.0f);
			[UIView animateWithDuration:0.5
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseOut
							 animations:^{
								 self.sideMenuViewController.view.frame = CGRectMake(self.PATStartPositionOfSideMenu, 0, self.view.bounds.size.width, self.view.bounds.size.height);
							 }
							 completion:nil];
		}
		
		if (self.PATStartPositionOfSettings >= -0.01) {
			self.PATStartPositionOfSettings = self.view.bounds.size.width*(-1.0f);
			[UIView animateWithDuration:0.5
								  delay:0.0
								options:UIViewAnimationOptionCurveEaseOut
							 animations:^{
								 self.settingsViewController.view.frame = CGRectMake(self.PATStartPositionOfSettings, 0, self.view.bounds.size.width, self.view.bounds.size.height);
							 }
							 completion:nil];
		}
	}
}


-(void) PATResetCameraAtLatitude:(double)latitude withLongitude:(double)longitude {
	self.mapViewController.mapView_.camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:8];
}


-(void) PATCameraToPlaceAtLatitude:(double)latitude withLongitude:(double)longitude {
	
	self.searchLocationViewController.inputTextField.text = @"";
	self.PATStartPositionOfSearchLocation = self.view.bounds.size.width*(-1.0f);
	self.searchLocationViewController.view.frame = CGRectMake(self.PATStartPositionOfSearchLocation, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	
	CLLocationCoordinate2D target;
	target.latitude = latitude;
	target.longitude = longitude;
	GMSCameraUpdate* updateCamera = [GMSCameraUpdate setTarget:target zoom:15];
	
	[self.mapViewController.mapView_ animateWithCameraUpdate:updateCamera];
}


- (void) PATBackToGoogleMap {
	
	self.PATStartPositionOfSearchLocation = self.view.bounds.size.width*(-1.0f);
	
	[UIView animateWithDuration:0.
					 animations:^{
						self.searchLocationViewController.view.frame = CGRectMake(self.PATStartPositionOfSearchLocation, 0, self.view.bounds.size.width, self.view.bounds.size.height);
					 }
					 completion:nil];
}


@end