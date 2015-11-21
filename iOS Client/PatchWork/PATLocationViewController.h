//
//  LocationViewController.h
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PATLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *horizontalAccuracy;
@property (strong, nonatomic) IBOutlet UILabel *altitude;
@property (strong, nonatomic) IBOutlet UILabel *verticalAccuracy;
@property (strong, nonatomic) IBOutlet UILabel *distance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startLocation;

- (IBAction)resetDistance:(id)sender;


@end





/* LocationViewController_h */
