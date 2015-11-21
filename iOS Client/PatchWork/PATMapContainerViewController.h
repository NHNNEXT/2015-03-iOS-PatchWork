//
//  MapContainerViewController.h
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 21..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PATGoogleMapViewController;

@protocol sideMenuShowUp
-(void) PATShowSideMenu;
@end

@interface PATMapContainerViewController : UIViewController<sideMenuShowUp>


@end




/* MapContainerViewController_h */
