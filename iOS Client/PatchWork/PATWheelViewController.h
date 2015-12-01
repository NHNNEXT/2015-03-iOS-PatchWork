//
//  CAYViewController.h
//  Circular Knob Demo
//
//  Created by Scott Erholm on 1/30/14.
//  Copyright (c) 2014 Cayuse Concepts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#include "PATSwirlGestureRecognizer.h"
#include "PATWheelTouchUpGestureRecognizer.h"
#include "PATWheelTouchDownGestureRecognizer.h"


@interface PATWheelViewController : UIViewController <PATSwirlGestureRecognizerDelegate, PATWheelTouchUpGestureRecognizerDelegate, PATWheelTouchDownGestureRecognizerDelegate, UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet UIView *controlsView;
@property (strong, nonatomic) IBOutlet UIImageView *knob;
@property (strong, nonatomic) IBOutlet UILabel *position;

 
@end
