//
//  GoogleMapViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATGoogleMapViewController.h"

@implementation PATGoogleMapViewController
{
	GMSMapView* _mapView;
}

- (void) viewDidLoad {
	
	[super viewDidLoad];
	
	// Load Google map (Note that an argument into mapWithFrame: is self.view.bounds instead of CGRectZero)
	GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:33.3000
															longitude:127.50000
																 zoom:1];
	_mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
	_mapView.myLocationEnabled = YES;
	[self.view addSubview:_mapView];
	
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
	
	
	
}

- (void)slideOutSideMenu {
	[self.delegate PATShowSideMenu];
}



@end