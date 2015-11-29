//
//  CAYViewController.m
//  Circular Knob Demo
//
//  Created by Scott Erholm on 1/30/14.
//  Copyright (c) 2014 Cayuse Concepts. All rights reserved.
//

#import "PATWheelViewController.h"

@interface PATWheelViewController ()

@property (strong, nonatomic) PATSwirlGestureRecognizer* swirlGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer* tapGestureRecognizer;
@property (strong, nonatomic) AVAudioPlayer* wheelSoundPlayer;

@end

@implementation PATWheelViewController

float bearing = 0.0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.swirlGestureRecognizer = [[PATSwirlGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    
    [self.swirlGestureRecognizer setDelegate:self];
    
    [self.controlsView addGestureRecognizer:self.swirlGestureRecognizer];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetToZero:)];
    
    [self.tapGestureRecognizer setDelegate:self];
    
    self.tapGestureRecognizer.numberOfTapsRequired = 2;
    
    [self.controlsView addGestureRecognizer:self.tapGestureRecognizer];
    
    [self.swirlGestureRecognizer requireGestureRecognizerToFail:self.tapGestureRecognizer];
}

- (void)playWheelSound {
    NSError * error;
    // wheelSound 디렉토리 각자 설정해야함.
    NSURL* wheelSoundURL = [NSURL URLWithString:@"file:///Users/Thomas/wheelSound.wav"]; 
    self.wheelSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wheelSoundURL error:&error];
    [self.wheelSoundPlayer play];
}

- (void)rotationAction:(id)sender {
    
    if([(PATSwirlGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGFloat direction = ((PATSwirlGestureRecognizer*)sender).currentAngle - ((PATSwirlGestureRecognizer*)sender).previousAngle;
    
    bearing += 180 * direction / M_PI;
    
    if (bearing < -0.5) {
        bearing += 360;
    }
    else if (bearing > 359.5) {
        bearing -= 360;
    }
    
    CGAffineTransform knobTransform = self.knob.transform;
    
    CGAffineTransform newKnobTransform = CGAffineTransformRotate(knobTransform, direction);

    [self.knob setTransform:newKnobTransform];
    
    self.position.text = [NSString stringWithFormat:@"%dº", (int)lroundf(bearing)];
    
    if ((int)bearing%45==0){
        [self playWheelSound];
    }
    
    if(bearing>=0 && bearing<45){
        self.position.text = @"and i'm feeling JOY";
    }
    else if (bearing>=45 && bearing<90){
        self.position.text = @"and i'm feeling TIRED";
    }
    else if (bearing>=90 && bearing<135){
        self.position.text = @"and i'm feeling FUN";
    }
    else if (bearing>=135 && bearing<180){
        self.position.text = @"and i'm feeling ANGRY";
    }
    else if (bearing>=180 && bearing<225){
        self.position.text = @"and i'm feeling SURPRISED";
    }
    else if (bearing>=225 && bearing<270){
        self.position.text = @"and i'm feeling SCARED";
    }
    else if (bearing>=270 && bearing<315){
        self.position.text = @"and i'm feeling SAD";
    }
    else{
        self.position.text = @"and i'm feeling EXCITED";
    }
}

- (void)resetToZero:(id)sender {
    [self animateRotationToBearing:0];
}

- (void)animateRotationToBearing:(int)direction {
    
    bearing = direction;
    
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(180 * direction / M_PI);
    
    [UIImageView beginAnimations:nil context:nil];
    [UIImageView setAnimationDelegate:self];
    [UIImageView setAnimationDuration:0.8f];
    [UIImageView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [self.knob setTransform:rotationTransform];
    
    [UIImageView commitAnimations];
    
    self.position.text = [NSString stringWithFormat:@"%dº", direction];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
