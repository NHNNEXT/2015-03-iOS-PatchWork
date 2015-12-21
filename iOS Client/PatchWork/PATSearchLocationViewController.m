//
//  PATSearchLocationViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 12. 16..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATSearchLocationViewController.h"


static NSString* cellIdentifier = @"cellIdentifier";


@interface PATSearchLocationViewController ()
{
	NSString* enteredPlace;
	NSMutableString* enteredPlaceID;
	NSMutableArray* placeArray;
	NSMutableArray* placeIDArray;
	double cameraLatitude;
	double cameraLongitude;
}
@end


@implementation PATSearchLocationViewController

- (void) viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
	
	[self setTextField];
	[self setPlaceTable];
}


// keyboard show

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (self.willShowKeyboard) {
		[self.inputTextField becomeFirstResponder];
	}
}


// text field create and addSubview

- (void) setTextField {
	
	self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*(1/15.0), self.view.bounds.origin.y + 30, self.view.bounds.size.width*(13/15.0), 40)];
	
	self.inputTextField.font = [UIFont fontWithName:@"Odin Rounded" size:self.view.bounds.size.width*0.05];
	self.inputTextField.placeholder = @"ENTER PLACE";
	self.inputTextField.textAlignment = NSTextAlignmentCenter;
	self.inputTextField.backgroundColor = [UIColor whiteColor];
	self.inputTextField.textColor = [UIColor colorWithRed:11/255.0 green:16/255.0 blue:41/255.0 alpha:0.5];
	
	[self.inputTextField setDelegate:self];
	
	[self.inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.inputTextField addTarget:self action:@selector(textInputDidFinish:) forControlEvents:UIControlEventEditingDidEndOnExit];
	
	[self.view addSubview:self.inputTextField];
}


// place table create and addSubview

- (void) setPlaceTable {
	
	self.predictedPlaceTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	
	[self.predictedPlaceTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
	
	[self.predictedPlaceTable setDataSource:self];
	[self.predictedPlaceTable setDelegate:self];
	
	self.predictedPlaceTable.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
	
	[self.view addSubview:self.predictedPlaceTable];
}


// text field methods implementation

- (void) textFieldDidChange: (id) sender {
	
	NSLog(@"text = %@", self.inputTextField.text);
	
	NSMutableString* temp_url = [[NSMutableString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input="];
	[temp_url appendString:self.inputTextField.text];
	[temp_url appendString:@"&types=geocode&key=AIzaSyA7jS3ywIDCjZsnuRywrNOacgCSOpi308c"];
	
	NSString* url = [temp_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
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
	
	NSArray* predictions = [json objectForKey:@"predictions"];
	
	placeArray = [NSMutableArray arrayWithCapacity:1];
	placeIDArray = [NSMutableArray arrayWithCapacity:1];
	
	for (NSDictionary* predictedPlace in predictions) {
		NSString* description = [predictedPlace objectForKey:@"description"];
		NSMutableString* placeID = [predictedPlace objectForKey:@"place_id"];
		
		[placeArray addObject:description];
		[placeIDArray addObject:placeID];
	}
	
	[self.predictedPlaceTable setFrame:CGRectMake(self.view.bounds.size.width*(1/15.0), self.view.bounds.origin.y + 80, self.view.bounds.size.width*(13/15.0), [placeArray count]*self.view.bounds.size.width*0.05*2.4)];
	
	if ([placeArray count] > 0) {
		self.predictedPlaceTable.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
	}
	
	[self.predictedPlaceTable reloadData];
}


- (void) textInputDidFinish: (id) sender {
	[sender endEditing:YES];
	
	enteredPlace = self.inputTextField.text;
	NSUInteger index = [placeArray indexOfObject:enteredPlace];
	enteredPlaceID = [placeIDArray objectAtIndex:index];
	
	NSLog(@"index = %ld", index);
	NSLog(@"place id = %@", enteredPlaceID);

	
	NSMutableString* placeID_url = [[NSMutableString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid="];
	[placeID_url appendString:enteredPlaceID];
	[placeID_url appendString:@"&key=AIzaSyA7jS3ywIDCjZsnuRywrNOacgCSOpi308c"];
	
	
	NSMutableURLRequest* place_request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:placeID_url]];
	[place_request setHTTPMethod:@"GET"];
	[place_request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
	
	NSError* place_error;
	NSURLResponse* place_response;
	NSData* place_responseData = [NSURLConnection sendSynchronousRequest:place_request
												 returningResponse:&place_response
															 error:&place_error];
	
	NSDictionary* place_json = [NSJSONSerialization JSONObjectWithData:place_responseData
														 options:NSJSONReadingMutableContainers
														   error:&place_error];
	
	NSDictionary* place_json_result = [place_json objectForKey:@"result"];
	NSDictionary* place_json_geometry = [place_json_result objectForKey:@"geometry"];
	NSDictionary* place_json_location = [place_json_geometry objectForKey:@"location"];
	NSString* place_lat = [place_json_location objectForKey:@"lat"];
	NSString* place_lon = [place_json_location objectForKey:@"lng"];
	
	NSLog(@"lat = %@,\n lon = %@", place_lat, place_lon);

	
}


// dataSource, delegate methods implementation - place table

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView {
	return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [placeArray count];
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	cell.textLabel.font = [UIFont fontWithName:@"Odin Rounded" size:self.view.bounds.size.width*0.05];
	cell.textLabel.textColor = [UIColor colorWithRed:11/255.0 green:16/255.0 blue:41/255.0 alpha:0.5];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [placeArray objectAtIndex:[indexPath row]]];

	return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	self.inputTextField.text = placeArray[[indexPath row]];
	[self.predictedPlaceTable reloadData];
}





@end