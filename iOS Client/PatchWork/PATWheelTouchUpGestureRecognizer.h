//
//  PATWheelTouchUpGestureRecognizer.h
//  PatchWork
//
//  Created by 김기범 on 2015. 11. 30..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <UIKit/UITouch.h>

@protocol PATWheelTouchUpGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@end

@interface PATWheelTouchUpGestureRecognizer : UIGestureRecognizer
@property CGFloat currentAngle;
@property CGFloat previousAngle;
@end
