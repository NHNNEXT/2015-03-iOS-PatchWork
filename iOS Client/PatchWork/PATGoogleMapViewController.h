//
//  GoogleMapViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@import GoogleMaps;

@protocol sideMenuShowUp
-(void) PATShowSideMenu;
@end


@interface PATGoogleMapViewController : UIViewController

@property (weak, nonatomic) id<sideMenuShowUp> delegate;

@end


/* GoogleMapViewController_h */
