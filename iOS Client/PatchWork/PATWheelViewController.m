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

@property (nonatomic) NSNumber* longitude;
@property (nonatomic) NSNumber* latitude;
@property (nonatomic) NSNumber* emotion;
@property (nonatomic) float bearing;

@end



@implementation PATWheelViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationServiceErrorView.hidden = YES;
	
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
    
    // 휠 돌리기 전까지 done버튼 비활성화
    [_doneButton setEnabled:NO];
    [_doneButton setTitleColor:[UIColor colorWithRed:255/255.f
                                               green:255/255.f
                                                blue:255/255.f
                                               alpha:0.0]
                      forState:UIControlStateNormal];
    _doneArrow.hidden = YES;
    _emotionInWheel.hidden = YES;
    
    // wheel을 터치할 때 wheel glow가 fade-in 할 수 있도록 애니메이션 적용
    self.knob.hidden = YES;
    self.knob.layer.shouldRasterize = YES;
    // viewDidLoad에서 애니메이션 효과를 바로 적용하려면 performSelector를 통해서 실행해야한다고 함.
    // http://stackoverflow.com/questions/2188664/how-to-add-an-animation-to-the-uiview-in-viewdidappear
    [self performSelector:@selector(givePulseAnimation) withObject:nil afterDelay:0.1f];
	
	// Location Manager setting
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	_locationManager.delegate = self;
	[_locationManager requestWhenInUseAuthorization];
	[_locationManager startMonitoringSignificantLocationChanges];
	[_locationManager startUpdatingLocation];
	
}







- (void)playWheelSound {
    if((int)_bearing%45 != 0){
        return;
    }
    NSError * error;
    // wheelSound 디렉토리는 각자 설정해야함.
    NSURL* wheelSoundURL = [NSURL URLWithString:@"file:///Users/Thomas/wheelSound.wav"]; 
    self.wheelSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:wheelSoundURL error:&error];
    [self.wheelSoundPlayer play];
}






- (void)giveAnimationToEmotion {
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.25;
    [self.emotionInWheel.layer addAnimation:animation forKey:nil];
    [self.emotionInWheel.layer addAnimation:animation forKey:nil];
    [self.position.layer addAnimation:animation forKey:nil];
}






- (void)giveAnimationToDoneButton {
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.9;
    [self.doneButton.layer addAnimation:animation forKey:nil];
    [self.doneArrow.layer addAnimation:animation forKey:nil];
}







- (void)doneButtonEnable {
    [self giveAnimationToDoneButton];
    [_doneButton setEnabled:YES];
    [_doneButton setTitleColor:[UIColor colorWithRed:255/255.f
                                               green:255/255.f
                                                blue:255/255.f
                                               alpha:1]
                      forState:UIControlStateNormal];
    
    _doneArrow.hidden = NO;
}







- (void)wheelGlowAppear:(id)sender {
    if([(PATWheelTouchDownGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        return;
    }
    NSLog(@"Appear");
    
    CGFloat movedPosition = 180 * ((PATWheelTouchDownGestureRecognizer*)sender).currentAngle / M_PI;
    CGFloat direction = (movedPosition - _bearing) * M_PI / 180;
    _bearing = movedPosition;
    
    [self transformRotate:direction];
    [self playWheelSound];
    [self updateFeelingText];
    [self doneButtonEnable];
    [self giveAnimationToKnob];
    [self giveAnimationToEmotion];
    self.knob.hidden = NO;
    _emotionInWheel.hidden = NO;
}






- (void)wheelGlowDisappear:(id)sender {
    NSLog(@"Disappear");
    
    [self giveAnimationToKnob];
    self.knob.hidden = YES;
}






- (void)givePulseAnimation {
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration=2;
    animation.repeatCount=HUGE_VALF;
    animation.autoreverses=YES;
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:1.04];
    [self.controlsView.layer addAnimation:animation forKey:@"transform.scale"];
    animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration=2;
    animation.repeatCount=HUGE_VALF;
    animation.autoreverses=YES;
    animation.fromValue=[NSNumber numberWithFloat:0.7];
    animation.toValue=[NSNumber numberWithFloat:1];
    [self.controlsView.layer addAnimation:animation forKey:@"opacity"];
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
    [self giveAnimationToEmotion];
    if(_bearing>=0 && _bearing<45){
        self.position.text = @"JOY";
        self.position.textColor = [UIColor colorWithRed:(199/255.f) green:(154/255.f) blue:(23/255.f)
                                                  alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"joy"]];
		self.emotion = @1;
    }
    else if (_bearing>=45 && _bearing<90){
        self.position.text = @"TIRED";
        self.position.textColor = [UIColor colorWithRed:(114/255.f) green:(80/255.f) blue:(46/255.f)
                                                  alpha:1.0];
		[self.emotionInWheel setImage:[UIImage imageNamed:@"tired"]];
		self.emotion = @2;
    }
    else if (_bearing>=90 && _bearing<135){
        self.position.text = @"FUN";
        self.position.textColor = [UIColor colorWithRed:(199/255.f) green:(87/255.f) blue:(25/255.f)alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"fun"]];
		self.emotion = @3;
    }
    else if (_bearing>=135 && _bearing<180){
        self.position.text = @"ANGRY";
        self.position.textColor = [UIColor colorWithRed:(194/255.f) green:(46/255.f) blue:(66/255.f)alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"angry"]];
		self.emotion = @4;
    }
    else if (_bearing>=180 && _bearing<225){
        self.position.text = @"SURPRISED";
        self.position.textColor = [UIColor colorWithRed:(208/255.f) green:(94/255.f) blue:(142/255.f)alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"surprised"]];
		self.emotion = @5;
    }
    else if (_bearing>=225 && _bearing<270){
        self.position.text = @"SCARED";
        self.position.textColor = [UIColor colorWithRed:(117/255.f) green:(62/255.f) blue:(146/255.f)alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"scared"]];
		self.emotion = @6;
    }
    else if (_bearing>=270 && _bearing<315){
        self.position.text = @"SAD";
        self.position.textColor = [UIColor colorWithRed:(79/255.f) green:(111/255.f) blue:(217/255.f)alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"sad"]];
		self.emotion = @7;
    }
    else{
        self.position.text = @"EXCITED";
        self.position.textColor = [UIColor colorWithRed:(90/255.f) green:(212/255.f) blue:(194/255.f)alpha:1.0];
        [self.emotionInWheel setImage:[UIImage imageNamed:@"excited"]];
		self.emotion = @8;
    }
}






- (void)rotationAction:(id)sender {
    if([(PATSwirlGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGFloat direction = ((PATSwirlGestureRecognizer*)sender).currentAngle - ((PATSwirlGestureRecognizer*)sender).previousAngle;
    
    _bearing += 180 * direction / M_PI;
    if (_bearing < -0.5) {
        _bearing += 360;
    }
    else if (_bearing > 359.5) {
        _bearing -= 360;
    }
    
    [self transformRotate:direction];
    
    if ((int)_bearing%45==0){
        [self playWheelSound];
    }
    
    [self giveAnimationToEmotion];
    [self updateFeelingText];
}






- (void) getCityName {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://ipinfo.io/json"]];
    
    __block NSDictionary *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
                               [self setCity:[json objectForKey:@"city"]];
                               self.city = [self.city uppercaseString];
                               NSLog(@"%@", [self city]);
                               self.cityLabel.text = self.city;
                           }];
}







- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
	self.latitude = [NSNumber numberWithDouble:currentLocation.coordinate.latitude];
	self.longitude = [NSNumber numberWithDouble:currentLocation.coordinate.longitude];

    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        
        // 도시 이름을 영어 이름으로 반환
        NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"en", nil] forKey:@"AppleLanguages"];
        
        for (CLPlacemark * placemark in placemarks) {
            self.city = [placemark locality];
            NSLog(@"city name : %@", self.city);
        }
        manager.stopUpdatingLocation;
        self.cityLabel.text = self.city;
        self.detectingLocationView.hidden = YES;
        // 언어 설정 원래대로 복구
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
        }];
    
}








- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.locationServiceErrorView.hidden = YES;
	NSLog(@"location manager instance error.");
}






- (IBAction)didDoneButtonTouched:(id)sender {

	NSLog(@"done button touched"); //
    
	NSMutableString *makePost = [NSMutableString stringWithCapacity:200];
	[makePost appendString:@"userid=12"];
	[makePost appendString:@"&lat="];
	[makePost appendString:[self.latitude stringValue]];
	[makePost appendString:@"&lon="];
	[makePost appendString:[self.longitude stringValue]];
	[makePost appendString:@"&emotion="];
	[makePost appendString:[self.emotion stringValue]];

	NSString *post = [NSString stringWithString:makePost];

	NSLog(@"%@", post); //
	NSLog(@"Make sure that Done Button CANNOT be operated if emotion was not selected."); //
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:@"http://localhost:5000/insertEmotion"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
