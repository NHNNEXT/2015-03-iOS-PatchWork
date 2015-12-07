//
//  SideMenuViewController.h
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class PATMapContainerViewController;

@interface PATSideMenuViewController : UIViewController

-(UIButton *) PATaddTextButtonWithTitle:(NSString *)title withFont:(NSString *)font withSize:(CGFloat) size;

@end