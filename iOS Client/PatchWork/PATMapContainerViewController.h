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
#import "PATTimeMachineViewController.h"

@class PATGoogleMapViewController;
@class PATSideMenuViewController;
@class PATSettingsViewController;
@class PATSearchLocationViewController;
@class PATTimeMachineViewController;

@interface PATMapContainerViewController : UIViewController<sideMenuShowUp, showSettingDelegate, emotionSelect, showTextFieldDelegate, cameraPositionReset, cameraToAnotherPlace, backToContainerFromSearchLocation, showTimeMachineDelegate,updateEmotionsDelegate, backToSettingsDelegate>

@property (nonatomic, strong) PATGoogleMapViewController* mapViewController;
@property (nonatomic, strong) PATSideMenuViewController* sideMenuViewController;
@property (nonatomic, strong) PATSettingsViewController* settingsViewController;
@property (nonatomic, strong) PATSearchLocationViewController* searchLocationViewController;
@property (nonatomic, strong) PATTimeMachineViewController* timeMachineViewController;
@property (nonatomic) float PATStartPositionOfSideMenu;
@property (nonatomic) float PATStartPositionOfSettings;
@property (nonatomic) float PATStartPositionOfSearchLocation;
@property (nonatomic) float PATStartPositionOfTimeMachine;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;


@end