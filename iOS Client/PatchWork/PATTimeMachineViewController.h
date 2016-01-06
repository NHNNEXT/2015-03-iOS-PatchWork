//
//  PATTimeMachineViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 12. 23..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PATGoogleMapViewController.h"

@protocol updateEmotionsDelegate
-(void) updateEmotions:(NSString*)time;
@end
@protocol backToSettingsDelegate
-(void) backToSettings;
@end


@interface PATTimeMachineViewController : UIViewController <UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) id<updateEmotionsDelegate, backToSettingsDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@end
