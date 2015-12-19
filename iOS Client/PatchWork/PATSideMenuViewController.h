//
//  SideMenuViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class PATMapContainerViewController;

@protocol showSettingFurther
-(void) PATShowSetting;
@end

@protocol showTextField
-(void) PATShowTextField;
@end

@interface PATSideMenuViewController : UIViewController

@property (weak, nonatomic) id<showSettingFurther, showTextField> delegate;

-(UIButton *) PATaddTextButtonWithTitle:(NSString *)title withFont:(NSString *)font withSize:(CGFloat) size;

@end