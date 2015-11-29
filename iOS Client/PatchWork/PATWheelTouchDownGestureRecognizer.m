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
    [super touchesBegan:touches withEvent:event];
    
    if (touches.count > 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [super setState:UIGestureRecognizerStateEnded];
    
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self];
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [super setState:UIGestureRecognizerStateCancelled];
}

@end