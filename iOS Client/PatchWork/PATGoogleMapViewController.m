//
//  GoogleMapViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATGoogleMapViewController.h"

@interface PATGoogleMapViewController ()

@property (nonatomic) CLLocation* currentLocation;

- (void) loadButtons;
- (void) loadJSON;
- (void) setCameraPositionToCurrentLocation;
- (void) addMarkersAtLatitude:(double)lat withLongitude:(double) lon havingEmotion:(int) emotion;
- (UIImage *) setMarkerShapeWithColor: (UIColor*) color;

@end


@implementation PATGoogleMapViewController 
{
	NSMutableArray* latArr;
	NSMutableArray* lonArr;
	NSMutableArray* emotionArr;
}

- (void) viewDidLoad {

	[super viewDidLoad];
	
	// Location Manager setting
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	_locationManager.delegate = self;
	[_locationManager requestWhenInUseAuthorization];
	[_locationManager startMonitoringSignificantLocationChanges];
	[_locationManager startUpdatingLocation];
    
//    self.patTimeMachineViewController = [[PATTimeMachineViewController alloc] init];
//    self.patTimeMachineViewController.delegate = self;
    
}


- (void) setInitialCameraAtLatitude:(double)latitude withLongitude:(double)longitude {
	
	// Load Google map (Note that an argument into mapWithFrame: is self.view.bounds instead of CGRectZero)
	GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:10];
	
	self.mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
	self.mapView_.myLocationEnabled = YES;
	[self.view addSubview:self.mapView_];
	
	[self loadJSON];
	[self loadButtons];
}


- (void)slideOutSideMenu {
	[self.delegate PATShowSideMenu];
}


- (void) showWheelView {
	[self.delegate PATShowEmotionView];
}


- (void) setCameraPositionToCurrentLocation {
	[self.delegate PATResetCameraAtLatitude:self.currentLocation.coordinate.latitude withLongitude:self.currentLocation.coordinate.longitude];
}


#pragma mark updateEmotionsDelegate
- (void) updateEmotions:(NSString*)time{
    NSLog(@"updateEmotions");
    [self deleteAllMarkers];
    [self loadJSON:time];
}



- (void) deleteAllMarkers {
    NSLog(@"deleted all markers!  %@", self.mapView_);
    [self.mapView_ clear];
}



- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
	self.currentLocation = [locations lastObject];
}


- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"location manager instance error.");
}


- (void) loadJSON
{
	NSURL* url = [NSURL URLWithString:@"http://52.192.198.85:5000/loadData"];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
	
	NSError* error;
	NSURLResponse* response;
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request
												 returningResponse:&response
															 error:&error];
	
	NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
														 options:NSJSONReadingMutableContainers
														   error:&error];
	NSDictionary* item = [json objectForKey:@"results"];

	latArr = [item valueForKey:@"lat"];
	lonArr = [item valueForKey:@"lon"];
	emotionArr = [item valueForKey:@"emotion"];

	for (int i = 0; i < [item count]; i++) {
		double lat = [latArr[i] doubleValue];
		double lon = [lonArr[i] doubleValue];
		int emotion = (int)[emotionArr[i] integerValue];
		
		[self addMarkersAtLatitude:lat
					 withLongitude:lon
					 havingEmotion:emotion];
	}
}





- (void) loadJSON:(NSString*)time
{
    NSLog(@"%@",time);
    time = [time componentsSeparatedByString:@"\nAgo"][0];
    time = [time stringByReplacingOccurrencesOfString:@"\\s"
                                           withString:@""
                                              options:NSRegularExpressionSearch
                                                range:NSMakeRange(0, time.length)];
    
    NSString* urlString = [NSString stringWithFormat:@"http://52.192.198.85:5000/loadData/%@",time];
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    
    NSError* error;
    NSURLResponse* response;
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    NSDictionary* item = [json objectForKey:@"results"];
    
    latArr = [item valueForKey:@"lat"];
    lonArr = [item valueForKey:@"lon"];
    emotionArr = [item valueForKey:@"emotion"];
    
    for (int i = 0; i < [item count]; i++) {
        double lat = [latArr[i] doubleValue];
        double lon = [lonArr[i] doubleValue];
        int emotion = (int)[emotionArr[i] integerValue];
        
        [self addMarkersAtLatitude:lat
                     withLongitude:lon
                     havingEmotion:emotion];
    }
}







- (void) addMarkersAtLatitude:(double)lat withLongitude:(double) lon havingEmotion:(int) emotion {
	
	CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lon);
	GMSMarker* marker = [GMSMarker markerWithPosition:position];
	
	switch (emotion) {
		case 1: {
			marker.title = @"JOY";
			UIColor* markerColor = [UIColor colorWithRed:210/255.0 green:168/255.0 blue:30/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_joy"];
			break;
		}
		case 2: {
			marker.title = @"TIRED";
			UIColor* markerColor = [UIColor colorWithRed:134/255.0 green:99/255.0 blue:59/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_tired"];
			break;
		}
		case 3: {
			marker.title = @"FUN";
			UIColor* markerColor = [UIColor colorWithRed:211/255.0 green:108/255.0 blue:31/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_fun"];
			break;
		}
		case 4: {
			marker.title = @"ANGRY";
			UIColor* markerColor = [UIColor colorWithRed:194/255.0 green:45/255.0 blue:66/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_angry"];
			break;
		}
		case 5: {
			marker.title = @"SURPRISED";
			UIColor* markerColor = [UIColor colorWithRed:221/255.0 green:98/255.0 blue:151/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_surprised"];
			break;
		}
		case 6: {
			marker.title = @"SCARED";
			UIColor* markerColor = [UIColor colorWithRed:117/255.0 green:62/255.0 blue:146/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_scared"];
			break;
		}
		case 7: {
			marker.title = @"SAD";
			UIColor* markerColor = [UIColor colorWithRed:79/255.0 green:111/255.0 blue:217/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_sad"];
			break;
		}
		case 8: {
			marker.title = @"EXCITED";
			UIColor* markerColor = [UIColor colorWithRed:97/255.0 green:238/255.0 blue:216/255.0 alpha:1.0];
			marker.icon = [self setMarkerShapeWithColor:markerColor];
            marker.icon = [UIImage imageNamed:@"marker_excited"];
			break;
		}
		default:
			break;
	}
	
    CGSize markerSize = CGSizeMake(52, 52);
    UIGraphicsBeginImageContextWithOptions(markerSize, NO, 0.0);
    [marker.icon drawInRect:CGRectMake(0, 0, markerSize.width, markerSize.height)];
    marker.icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
	marker.map = self.mapView_;
    
}


- (UIImage *) setMarkerShapeWithColor: (UIColor*) color {
	
	UIImage* markerImage;
	UIGraphicsBeginImageContext(CGSizeMake(20, 20));
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, 0.0);
	//CGContextSetStrokeColorWithColor(context, color.CGColor);
	[markerImage drawInRect:CGRectMake(0, 0, 20, 20)];
	CGContextAddEllipseInRect(context, CGRectMake(0, 0, 20, 20));
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillPath(context);
	
	markerImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return markerImage;
}





- (void) loadButtons
{
	// Load sideMenuButton with hamburger image on the top left corner
	UIButton* sideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *hamburger = [UIImage imageNamed:@"hamburger"];
	[sideMenuButton setImage:hamburger forState:UIControlStateNormal];
	[sideMenuButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:sideMenuButton];
	
	// Set autoLayout (top, leading, width, height) for sideMenuButton
	NSLayoutConstraint* buttonLeadConstraint = [NSLayoutConstraint constraintWithItem:sideMenuButton
																			attribute:NSLayoutAttributeLeading
																			relatedBy:NSLayoutRelationEqual
																			   toItem:self.view
																			attribute:NSLayoutAttributeLeading
																		   multiplier:1.0
																			 constant:15.0];
	[self.view addConstraint:buttonLeadConstraint];
	
	NSLayoutConstraint* buttonTopConstraint = [NSLayoutConstraint constraintWithItem:sideMenuButton
																		   attribute:NSLayoutAttributeTop
																		   relatedBy:NSLayoutRelationEqual
																			  toItem:self.view
																		   attribute:NSLayoutAttributeTop
																		  multiplier:1.0
																			constant:30.0];
	[self.view addConstraint:buttonTopConstraint];
	
	[sideMenuButton addConstraint:[NSLayoutConstraint constraintWithItem:sideMenuButton
															   attribute:NSLayoutAttributeWidth
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeWidth
															  multiplier:1.0
																constant:45.0]];
	[sideMenuButton addConstraint:[NSLayoutConstraint constraintWithItem:sideMenuButton
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeHeight
															  multiplier:1.0
																constant:45.0]];
	
	[sideMenuButton addTarget: self
					   action: @selector(slideOutSideMenu)
			 forControlEvents:UIControlEventTouchUpInside];
	
	
	// Load emotionButton with plus image on the bottom right corner
	UIButton* emotionButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *plus = [UIImage imageNamed:@"plusEmotion"];
	[emotionButton setImage:plus forState:UIControlStateNormal];
	[emotionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:emotionButton];
	
	// Set autoLayout (top, leading, width, height) for emotionButton
	NSLayoutConstraint* plusLeadConstraint = [NSLayoutConstraint constraintWithItem:emotionButton
																		  attribute:NSLayoutAttributeTrailing
																		  relatedBy:NSLayoutRelationEqual
																			 toItem:self.view
																		  attribute:NSLayoutAttributeTrailing
																		 multiplier:1.0
																		   constant:-17.0];
	[self.view addConstraint:plusLeadConstraint];
	
	NSLayoutConstraint* plusBottomConstraint = [NSLayoutConstraint constraintWithItem:emotionButton
																			attribute:NSLayoutAttributeBottom
																			relatedBy:NSLayoutRelationEqual
																			   toItem:self.view
																			attribute:NSLayoutAttributeBottom
																		   multiplier:1.0
																			 constant:-30.0];
	[self.view addConstraint:plusBottomConstraint];
	
	[emotionButton addConstraint:[NSLayoutConstraint constraintWithItem:emotionButton
															  attribute:NSLayoutAttributeWidth
															  relatedBy:NSLayoutRelationEqual
																 toItem:nil
															  attribute:NSLayoutAttributeWidth
															 multiplier:1.0
															   constant:50.0]];
	[emotionButton addConstraint:[NSLayoutConstraint constraintWithItem:emotionButton
															  attribute:NSLayoutAttributeHeight
															  relatedBy:NSLayoutRelationEqual
																 toItem:nil
															  attribute:NSLayoutAttributeHeight
															 multiplier:1.0
															   constant:50.0]];
	[emotionButton addTarget: self
					  action: @selector(showWheelView)
			forControlEvents:UIControlEventTouchUpInside];
	
	
	// Load locationButton with arrow image on the top right corner
	UIButton* locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *arrow = [UIImage imageNamed:@"currentPosition@2x"];
	[locationButton setImage:arrow forState:UIControlStateNormal];
	[locationButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:locationButton];
	
	// Set autoLayout (top, leading, width, height) for locationButton
	NSLayoutConstraint* arrowLeadConstraint = [NSLayoutConstraint constraintWithItem:locationButton
																		   attribute:NSLayoutAttributeTrailing
																		   relatedBy:NSLayoutRelationEqual
																			  toItem:self.view
																		   attribute:NSLayoutAttributeTrailing
																		  multiplier:1.0
																			constant:-19.0];
	[self.view addConstraint:arrowLeadConstraint];
	
	NSLayoutConstraint* arrowTopConstraint = [NSLayoutConstraint constraintWithItem:locationButton
																		  attribute:NSLayoutAttributeTop
																		  relatedBy:NSLayoutRelationEqual
																			 toItem:self.view
																		  attribute:NSLayoutAttributeTop
																		 multiplier:1.0
																		   constant:31.0];
	[self.view addConstraint:arrowTopConstraint];
	
	[locationButton addConstraint:[NSLayoutConstraint constraintWithItem:locationButton
															   attribute:NSLayoutAttributeWidth
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeWidth
															  multiplier:1.0
																constant:44.0]];
	[locationButton addConstraint:[NSLayoutConstraint constraintWithItem:locationButton
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeHeight
															  multiplier:1.0
																constant:44.0]];
	
	[locationButton addTarget: self
					   action: @selector(setCameraPositionToCurrentLocation)
			 forControlEvents:UIControlEventTouchUpInside];
	
	// Load transparentButton on the bottom left corner
	UIButton* transparentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[transparentButton setTitle:@"Google" forState:UIControlStateNormal];
	transparentButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
	[transparentButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.0] forState:UIControlStateNormal];
	[transparentButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:transparentButton];
	
	// Set autoLayout (top, leading, width, height) for locationButton
	NSLayoutConstraint* transparentLeadConstraint = [NSLayoutConstraint constraintWithItem:transparentButton
																		   attribute:NSLayoutAttributeLeading
																		   relatedBy:NSLayoutRelationEqual
																			  toItem:self.view
																		   attribute:NSLayoutAttributeLeading
																		  multiplier:1.0
																			constant:0.0];
	[self.view addConstraint:transparentLeadConstraint];
	
	NSLayoutConstraint* transparentTopConstraint = [NSLayoutConstraint constraintWithItem:transparentButton
																		  attribute:NSLayoutAttributeBottom
																		  relatedBy:NSLayoutRelationEqual
																			 toItem:self.view
																		  attribute:NSLayoutAttributeBottom
																		 multiplier:1.0
																		   constant:0.0];
	[self.view addConstraint:transparentTopConstraint];
	
	[transparentButton addConstraint:[NSLayoutConstraint constraintWithItem:transparentButton
															   attribute:NSLayoutAttributeWidth
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeWidth
															  multiplier:1.0
																constant:80.0]];
	[transparentButton addConstraint:[NSLayoutConstraint constraintWithItem:transparentButton
															   attribute:NSLayoutAttributeHeight
															   relatedBy:NSLayoutRelationEqual
																  toItem:nil
															   attribute:NSLayoutAttributeHeight
															  multiplier:1.0
																constant:30.0]];
}

@end