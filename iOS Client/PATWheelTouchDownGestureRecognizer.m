//
//  PATWheelTouchDownGestureRecognizer.m
//  PatchWork
//
//  Created by 김기범 on 2015. 11. 30..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATWheelTouchDownGestureRecognizer.h"

@interface PATWheelTouchDownGestureRecognizer ()

@property (strong, nonatomic) id target;
@property (nonatomic) SEL action;
@end


@implementation PATWheelTouchDownGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action {
    
    if (self = [super initWithTarget:target action:action]) {
        self.target = target;
        self.action = action;
    }
    
    return self;
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event {
    NSLog(@"Touched!");

    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    self.currentAngle = [self getTouchAngle:[touch locationInView:touch.view]];
    
    if (touches.count > 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self];
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [super setState:UIGestureRecognizerStateEnded];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [super setState:UIGestureRecognizerStateCancelled];
}

- (float)getTouchAngle:(CGPoint)touch {
    
    // Translate into cartesian space with origin at the center of a 320-pixel square
    float x = touch.x - 160;
    float y = -(touch.y - 160);
    
    // Take care not to divide by zero!
    if (y == 0) {
        if (x > 0) {
            return M_PI_2;
        }
        else {
            return 3 * M_PI_2;
        }
    }
    
    float arctan = atanf(x/y);
    
    // Figure out which quadrant we're in
    
    // Quadrant I
    if ((x >= 0) && (y > 0)) {
        return arctan;
    }
    // Quadrant II
    else if ((x < 0) && (y > 0)) {
        return arctan + 2 * M_PI;
    }
    // Quadrant III
    else if ((x <= 0) && (y < 0)) {
        return arctan + M_PI;
    }
    // Quadrant IV
    else if ((x > 0) && (y < 0)) {
        return arctan + M_PI;
    }
    
    return -1;
}

@end