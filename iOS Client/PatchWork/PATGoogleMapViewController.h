//
//  GoogleMapViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "PATTimeMachineViewController.h"

@import GoogleMaps;

@protocol sideMenuShowUp
-(void) PATShowSideMenu;
@end

@protocol emotionSelect
-(void) PATShowEmotionView;
@end

@protocol cameraPositionReset
-(void) PATResetCameraAtLatitude:(double)latitude withLongitude:(double)longitude;
@end



@interface PATGoogleMapViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) id<sideMenuShowUp, emotionSelect, cameraPositionReset> delegate;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) GMSMapView* mapView_;

//@property (strong, nonatomic) PATTimeMachineViewController* patTimeMachineViewController;

- (void) updateEmotions:(NSString*)time;
- (void) deleteAllMarkers;
- (void) setInitialCameraAtLatitude:(double) latitude withLongitude:(double) longitude;

@end