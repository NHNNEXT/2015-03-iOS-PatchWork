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
	
	// Set googleMapVC and sideMenuVC as properties, and add googleMapVC as a Subview
	self.mapViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATGoogleMapViewController"];
	self.sideMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSideMenuViewController"];
	
	[self addChildViewController:self.mapViewController];
	self.mapViewController.view.frame = self.view.bounds;
	[self.view addSubview:self.mapViewController.view];
	self.mapViewController.delegate = self;
	[self.mapViewController didMoveToParentViewController:self];
}


-(void) PATShowSideMenu:(BOOL) YesOrNo {
	
	if (YesOrNo) {
		self.isSideMenuButtonOn = YES;
		[self PATLoadSideMenuView];
	}
}


-(void) PATLoadSideMenuView {
	
	[self addChildViewController:self.sideMenuViewController];
	self.sideMenuViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width*0.6f, self.view.bounds.size.height);
	[self.view addSubview:self.sideMenuViewController.view];
	[self.sideMenuViewController didMoveToParentViewController:self];
}


@end