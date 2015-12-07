//
//  MapContainerViewController.h
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 21..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PATGoogleMapViewController.h"
#import "PATSideMenuViewController.h"
#import "PATSettingsViewController.h"
@class PATGoogleMapViewController;
@class PATSideMenuViewController;
@class PATSettingsViewController;

@interface PATMapContainerViewController : UIViewController<sideMenuShowUp>

@property (nonatomic, strong) PATGoogleMapViewController* mapViewController;
@property (nonatomic, strong) PATSideMenuViewController* sideMenuViewController;
@property (nonatomic, strong) PATSettingsViewController* settingsViewController;
@property (nonatomic) float PATStartPositionOfSideMenu;
@property (nonatomic) float PATStartPositionOfSettings;

@end