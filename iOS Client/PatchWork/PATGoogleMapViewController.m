//
//  GoogleMapViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATGoogleMapViewController.h"

@interface PATGoogleMapViewController ()

@property (nonatomic) CLLocation* currentLocation;

- (void) setCameraPositionToCurrentLocation;

@end


@implementation PATGoogleMapViewController 
{
	GMSMapView* mapView_;
}

- (void) viewDidLoad {
	
	[super viewDidLoad];
	
	// Location Manager setting
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	_locationManager.delegate = self;
	[_locationManager requestWhenInUseAuthorization];
	[_locationManager startMonitoringSignificantLocationChanges];
	[_locationManager startUpdatingLocation];
	
	// Load Google map (Note that an argument into mapWithFrame: is self.view.bounds instead of CGRectZero)
	GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
															longitude:self.currentLocation.coordinate.longitude
																 zoom:1];
	mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
	mapView_.myLocationEnabled = YES;
	[self.view addSubview:mapView_];
	
	// Load sideMenuButton with hamburger image on the top left corner
	UIButton* sideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *hamburger = [UIImage imageNamed:@"hamburger.gif"];
	[sideMenuButton setImage:hamburger forState:UIControlStateNormal];
	[sideMenuButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:sideMenuButton];
	
	// Set autoLayout (top, leading, width, height) for sideMenuButton
	NSLayoutConstraint* buttonLeadConstraint = [NSLayoutConstraint constraintWithItem:sideMenuButton
																			attribute:NSLayoutAttributeLeading
																			relatedBy:NSLayoutRelationEqual
																			   toItem:self.view
																			attribute:NSLayoutAttributeLeading
																		   multiplier:1.0
																			 constant:20.0];
	[self.view addConstraint:buttonLeadConstraint];
	
	NSLayoutConstraint* buttonTopConstraint = [NSLayoutConstraint constraintWithItem:sideMenuButton
																		   attribute:NSLayoutAttributeTop
																		   relatedBy:NSLayoutRelationEqual
																			  toItem:self.view
																		   attribute:NSLayoutAttributeTop
																		  multiplier:1.0
																			constant:30.0];
	[self.view addConstraint:buttonTopConstraint];
	
	[sideMenuButton addConstraint:[NSLayoutConstraint constraintWithItem:sideMenuButton
															   attribute:NSLayoutAttributeWidth
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeWidth
															  multiplier:1.0
																constant:50.0]];
	[sideMenuButton addConstraint:[NSLayoutConstraint constraintWithItem:sideMenuButton
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeHeight
															  multiplier:1.0
																constant:50.0]];
	
	[sideMenuButton addTarget: self
					   action: @selector(slideOutSideMenu)
			 forControlEvents:UIControlEventTouchUpInside];
	
	
	// Load emotionButton with plus image on the bottom right corner
	UIButton* emotionButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *plus = [UIImage imageNamed:@"plusEmotion.gif"];
	[emotionButton setImage:plus forState:UIControlStateNormal];
	[emotionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:emotionButton];
	
	// Set autoLayout (top, leading, width, height) for emotionButton
	NSLayoutConstraint* plusLeadConstraint = [NSLayoutConstraint constraintWithItem:emotionButton
																			attribute:NSLayoutAttributeTrailing
																			relatedBy:NSLayoutRelationEqual
																			   toItem:self.view
																			attribute:NSLayoutAttributeTrailing
																		   multiplier:1.0
																			 constant:-20.0];
	[self.view addConstraint:plusLeadConstraint];
	
	NSLayoutConstraint* plusBottomConstraint = [NSLayoutConstraint constraintWithItem:emotionButton
																		   attribute:NSLayoutAttributeBottom
																		   relatedBy:NSLayoutRelationEqual
																			  toItem:self.view
																		   attribute:NSLayoutAttributeBottom
																		  multiplier:1.0
																			constant:-20.0];
	[self.view addConstraint:plusBottomConstraint];
	
	[emotionButton addConstraint:[NSLayoutConstraint constraintWithItem:emotionButton
															   attribute:NSLayoutAttributeWidth
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeWidth
															  multiplier:1.0
																constant:50.0]];
	[emotionButton addConstraint:[NSLayoutConstraint constraintWithItem:emotionButton
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeHeight
															  multiplier:1.0
																constant:50.0]];
	[emotionButton addTarget: self
					  action: @selector(showWheelView)
			forControlEvents:UIControlEventTouchUpInside];
	
	
	// Load locationButton with arrow image on the top right corner
	UIButton* locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *arrow = [UIImage imageNamed:@"currentPosition.gif"];
	[locationButton setImage:arrow forState:UIControlStateNormal];
	[locationButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:locationButton];
	
	// Set autoLayout (top, leading, width, height) for locationButton
	NSLayoutConstraint* arrowLeadConstraint = [NSLayoutConstraint constraintWithItem:locationButton
																			attribute:NSLayoutAttributeTrailing
																			relatedBy:NSLayoutRelationEqual
																			   toItem:self.view
																			attribute:NSLayoutAttributeTrailing
																		   multiplier:1.0
																			 constant:-20.0];
	[self.view addConstraint:arrowLeadConstraint];
	
	NSLayoutConstraint* arrowTopConstraint = [NSLayoutConstraint constraintWithItem:locationButton
																		   attribute:NSLayoutAttributeTop
																		   relatedBy:NSLayoutRelationEqual
																			  toItem:self.view
																		   attribute:NSLayoutAttributeTop
																		  multiplier:1.0
																			constant:40.0];
	[self.view addConstraint:arrowTopConstraint];
	
	[locationButton addConstraint:[NSLayoutConstraint constraintWithItem:locationButton
															   attribute:NSLayoutAttributeWidth
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeWidth
															  multiplier:1.0
																constant:30.0]];
	[locationButton addConstraint:[NSLayoutConstraint constraintWithItem:locationButton
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeHeight
															  multiplier:1.0
																constant:30.0]];
	
	[locationButton addTarget: self
					   action: @selector(setCameraPositionToCurrentLocation)
			 forControlEvents:UIControlEventTouchUpInside];
	
}


- (void)slideOutSideMenu {
	[self.delegate PATShowSideMenu];
}


- (void) showWheelView {
	[self.delegate PATShowEmotionView];
}


- (void) setCameraPositionToCurrentLocation {
	CLLocationCoordinate2D target = CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
	mapView_.camera = [GMSCameraPosition cameraWithTarget:target zoom:1];
}


- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
	self.currentLocation = [locations lastObject];
}


- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"location manager instance error.");
}


@end