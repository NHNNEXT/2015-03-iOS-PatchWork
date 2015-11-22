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
@class PATGoogleMapViewController;
@class PATSideMenuViewController;

@interface PATMapContainerViewController : UIViewController<sideMenuShowUp>

@property (nonatomic, strong) PATGoogleMapViewController* mapViewController;
@property (nonatomic, strong) PATSideMenuViewController* sideMenuViewController;

@property (nonatomic) BOOL isSideMenuButtonOn;

- (void) PATLoadSideMenuView;

@end




/* MapContainerViewController_h */
