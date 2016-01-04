//
//  CAYSwirlGestureRecognizer.h
//  Sense Of Direction
//
//  Created by Scott Erholm on 10/14/13.
//  Copyright (c) 2013 Cayuse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <UIKit/UITouch.h>

@protocol PATSwirlGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@end

@interface PATSwirlGestureRecognizer : UIGestureRecognizer

@property CGFloat currentAngle;
@property CGFloat previousAngle;
@property UITouch* touch;

@end
