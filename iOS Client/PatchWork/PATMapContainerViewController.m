//
//  MapContainerViewController.m
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 21..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PATMapContainerViewController.h"


@implementation PATMapContainerViewController

-(void) viewDidLoad{
	UIViewController * MapController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATGoogleMapViewController"];
	[self addChildViewController:MapController];
	MapController.view.bounds = self.view.bounds;
	[self.view addSubview:MapController.view];

//	[MapController didMoveToParentViewController:self];
}

-(void) PATShowSideMenu {
	UIViewController * sideMenuController = [self.storyboard instantiateViewControllerWithIdentifier:@"PATSideMenuViewController"];
	[self addChildViewController:sideMenuController];
	sideMenuController.view.bounds = CGRectMake(0, 0, self.view.bounds.size.width*0.6f, self.view.bounds.size.height);
	[self.view addSubview:sideMenuController.view];
//	[sideMenuController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end