//
//  PATWheelTouchDownGestureRecognizer.h
//  PatchWork
//
//  Created by 김기범 on 2015. 11. 30..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <UIKit/UITouch.h>

@protocol PATWheelTouchDownGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@end

@interface PATWheelTouchDownGestureRecognizer : UIGestureRecognizer
@property CGFloat currentAngle;
@property UITouch* touch;
@end

