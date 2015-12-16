//
//  MapContainerViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 11. 21..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PATGoogleMapViewController.h"
#import "PATSideMenuViewController.h"
#import "PATSettingsViewController.h"
#import "PATSearchLocationViewController.h"
@class PATGoogleMapViewController;
@class PATSideMenuViewController;
@class PATSettingsViewController;
@class PATSearchLocationViewController;

@interface PATMapContainerViewController : UIViewController<sideMenuShowUp, showSettingFurther, emotionSelect>

@property (nonatomic, strong) PATGoogleMapViewController* mapViewController;
@property (nonatomic, strong) PATSideMenuViewController* sideMenuViewController;
@property (nonatomic, strong) PATSettingsViewController* settingsViewController;
@property (nonatomic, strong) PATSearchLocationViewController* searchLocationViewController;
@property (nonatomic) float PATStartPositionOfSideMenu;
@property (nonatomic) float PATStartPositionOfSettings;
@property (nonatomic) float PATStartPositionOfSearchLocation;

@end