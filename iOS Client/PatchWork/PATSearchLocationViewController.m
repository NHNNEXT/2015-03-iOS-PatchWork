//
//  PATSearchLocationViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 12. 16..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATSearchLocationViewController.h"

@implementation PATSearchLocationViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	
	NSLog(@"searchLocation View Controller Loaded");
	
	self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
	
	UITextField* inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*(1/15.0), self.view.bounds.origin.y + 30, self.view.bounds.size.width*(13/15.0), 40)];
	
	inputTextField.font = [UIFont fontWithName:@"Odin Rounded" size:self.view.bounds.size.width*0.05];
	inputTextField.text = @"ENTER PLACE";
	inputTextField.textAlignment = NSTextAlignmentCenter;
	inputTextField.backgroundColor = [UIColor whiteColor];
	inputTextField.textColor = [UIColor colorWithRed:11/255.0 green:16/255.0 blue:41/255.0 alpha:1.0];
	
	[self.view addSubview:inputTextField];

}


@end
