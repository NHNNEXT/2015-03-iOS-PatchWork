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
@property (strong, nonatomic) PATWheelTouchUpGestureRecognizer* touchUpGestureRecognizer;
@property (strong, nonatomic) PATWheelTouchDownGestureRecognizer* touchDownGestureRecognizer;
@property (strong, nonatomic) AVAudioPlayer* wheelSoundPlayer;
@property (strong, nonatomic) NSString* city;

@end

@implementation PATWheelViewController

float bearing = 0.0;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.swirlGestureRecognizer = [[PATSwirlGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [self.swirlGestureRecognizer setDelegate:self];
    [self.controlsView addGestureRecognizer:self.swirlGestureRecognizer];
    
    self.touchDownGestureRecognizer = [[PATWheelTouchDownGestureRecognizer alloc] initWithTarget:self action:@selector(wheelGlowAppear:)];
    [self.touchDownGestureRecognizer setDelegate:self];
    [self.controlsView addGestureRecognizer:self.touchDownGestureRecognizer];
    
    self.touchUpGestureRecognizer = [[PATWheelTouchUpGestureRecognizer alloc] initWithTarget:self action:@selector(wheelGlowDisappear:)];
    [self.touchUpGestureRecognizer setDelegate:self];
    [self.controlsView addGestureRecognizer:self.touchUpGestureRecognizer];

    [self.swirlGestureRecognizer requireGestureRecognizerToFail:self.touchDownGestureRecognizer];
    
    self.knob.hidden = YES;
    // wheel을 터치할 때 wheel glow가 fade-in 할 수 있도록 애니메이션 적용
    self.knob.layer.shouldRasterize = YES;
    
    [self getCityName];
}



- (void)playWheelSound {
    if((int)bearing%45 != 0){
        return;
    }
    NSError * error;
    // wheelSound 디렉토리는 각자 설정해야함.
    NSURL* wheelSoundURL = [NSURL URLWithString:@"file:///Users/Thomas/wheelSound.wav"]; 
    self.wheelSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wheelSoundURL error:&error];
    [self.wheelSoundPlayer play];
}



- (void)wheelGlowAppear:(id)sender {
    if([(PATWheelTouchDownGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        return;
    }
    NSLog(@"Appear");
    
    CGFloat movedPosition = 180 * ((PATWheelTouchDownGestureRecognizer*)sender).currentAngle / M_PI;
    CGFloat direction = (movedPosition - bearing) * M_PI / 180;
    bearing = movedPosition;
    [self transformRotate:direction];
    
    [self playWheelSound];
    
    [self updateFeelingText];
    
    [self giveAnimationToKnob];
    self.knob.hidden = NO;
}



- (void)wheelGlowDisappear:(id)sender {
    NSLog(@"Disappear");
    
    [self giveAnimationToKnob];
    self.knob.hidden = YES;
}



- (void)giveAnimationToKnob {
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.knob.layer addAnimation:animation forKey:nil];
}



- (void)transformRotate: (CGFloat) direction {
    CGAffineTransform knobTransform = self.knob.transform;
    CGAffineTransform newKnobTransform = CGAffineTransformRotate(knobTransform, direction);
    [self.knob setTransform:newKnobTransform];
}



- (void)updateFeelingText {
    if(bearing>=0 && bearing<45){
        self.position.text = @"JOY";
        self.position.textColor = [UIColor colorWithRed:(199/255.f) green:(154/255.f) blue:(23/255.f)
                                                  alpha:1.0];
}
    else if (bearing>=45 && bearing<90){
        self.position.text = @"TIRED";
        self.position.textColor = [UIColor colorWithRed:(114/255.f) green:(80/255.f) blue:(46/255.f)
                                                  alpha:1.0];
        //[self.emotionInWheel.image
    }
    else if (bearing>=90 && bearing<135){
        self.position.text = @"FUN";
        self.position.textColor = [UIColor colorWithRed:(199/255.f) green:(87/255.f) blue:(25/255.f)alpha:1.0];
    }
    else if (bearing>=135 && bearing<180){
        self.position.text = @"ANGRY";
        self.position.textColor = [UIColor colorWithRed:(194/255.f) green:(46/255.f) blue:(66/255.f)alpha:1.0];
    }
    else if (bearing>=180 && bearing<225){
        self.position.text = @"SURPRISED";
        self.position.textColor = [UIColor colorWithRed:(208/255.f) green:(94/255.f) blue:(142/255.f)alpha:1.0];
    }
    else if (bearing>=225 && bearing<270){
        self.position.text = @"SCARED";
        self.position.textColor = [UIColor colorWithRed:(117/255.f) green:(62/255.f) blue:(146/255.f)alpha:1.0];
    }
    else if (bearing>=270 && bearing<315){
        self.position.text = @"SAD";
        self.position.textColor = [UIColor colorWithRed:(79/255.f) green:(111/255.f) blue:(217/255.f)alpha:1.0];
    }
    else{
        self.position.text = @"EXCITED";
        self.position.textColor = [UIColor colorWithRed:(90/255.f) green:(212/255.f) blue:(194/255.f)alpha:1.0];
    }
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
    
    [self transformRotate:direction];
    
    if ((int)bearing%45==0){
        [self playWheelSound];
    }
    
    [self updateFeelingText];
}


- (void) getCityName {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://ip-api.com/json"]];
    
    __block NSDictionary *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
                               [self setCity:[json objectForKey:@"city"]];
                               NSLog(@"%@", [self city]);
                               self.cityLabel.text = self.city;
                           }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
