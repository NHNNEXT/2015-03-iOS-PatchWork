//
//  PATTimeMachineViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 12. 23..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PATTimeMachineViewController : UIViewController <UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end