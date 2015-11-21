//
//  LocationViewController.m
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PATLocationViewController.h"


@implementation PATLocationViewController


- (void) viewDidLoad {
	[super viewDidLoad];
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	_locationManager.delegate = self;
	[_locationManager requestWhenInUseAuthorization];
	[_locationManager startMonitoringSignificantLocationChanges];
	[_locationManager startUpdatingLocation];
	_startLocation = nil;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
	
	CLLocation *newLocation = [locations lastObject];
	CLLocation *oldLocation;
	
	if (locations.count > 1) {
		oldLocation = [locations objectAtIndex:locations.count-2];
	} else {
		oldLocation = nil;
	}
	
	NSString *currentLatitude = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.coordinate.latitude];
	self.latitude.text = currentLatitude;
	
	NSString *currentLongitude = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.coordinate.longitude];
	self.longitude.text = currentLongitude;
	
	NSString *currentHorizontalAccuracy = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.horizontalAccuracy];
	self.horizontalAccuracy.text = currentHorizontalAccuracy;
	
	NSString *currentAltitude = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.horizontalAccuracy];
	self.altitude.text = currentAltitude;
	
	NSString *currentVerticalAccuracy = [[NSString alloc] initWithFormat:@"%+.6f", newLocation.verticalAccuracy];
	self.verticalAccuracy.text = currentVerticalAccuracy;

	if (self.startLocation == nil) {
		self.startLocation = newLocation;
	}
	
	CLLocationDistance distanceBetween = [newLocation distanceFromLocation:self.startLocation];
	
	NSString *tripString = [[NSString alloc] initWithFormat:@"%f", distanceBetween];
	self.distance.text = tripString;

}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"location manager instance error.");
}

- (IBAction)resetDistance:(id)sender {
	_startLocation = nil;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end