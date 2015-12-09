//
//  SideMenuViewController.m
//  LocAndEtc
//
//  Created by BgKim on 2015. 11. 20..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATSideMenuViewController.h"

@implementation PATSideMenuViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	
	CALayer *leftSideLayer = [CALayer layer];
	leftSideLayer.backgroundColor = [UIColor colorWithRed:11/255.0
													green:16/255.0
													 blue:41/255.0
													alpha:1.0].CGColor;
	leftSideLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width*0.6f, self.view.bounds.size.height);
	
	self.view.layer.backgroundColor = [UIColor colorWithRed:1.0
													  green:1.0
													   blue:1.0
													  alpha:0.0].CGColor;
	
	[self.view.layer addSublayer:leftSideLayer];
	
	// Time Machine Button
	UIButton* timeMachineButton = [self PATaddTextButtonWithTitle:@"TIME MACHINE"
														 withFont:@"Odin Rounded"
														 withSize:self.view.bounds.size.width*0.05];
	
	[timeMachineButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:timeMachineButton];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:timeMachineButton
														  attribute:NSLayoutAttributeCenterY
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterY
														 multiplier:1.0
														   constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:timeMachineButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeLeading
														 multiplier:1.0
														   constant:self.view.bounds.size.width*0.3f]];

	
	// Search Place Button
	UIButton* searchPlaceButton = [self PATaddTextButtonWithTitle:@"SEARCH PLACE"
														 withFont:@"Odin Rounded"
														 withSize:self.view.bounds.size.width*0.05];
	
	[searchPlaceButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:searchPlaceButton];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchPlaceButton
														  attribute:NSLayoutAttributeTop
														  relatedBy:NSLayoutRelationEqual
															 toItem:timeMachineButton
														  attribute:NSLayoutAttributeTop
														 multiplier:1.0
														   constant:self.view.bounds.size.height*(-0.1)]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchPlaceButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeLeading
														 multiplier:1.0
														   constant:self.view.bounds.size.width*0.3f]];
	
	// Settings Button
	UIButton* settingsButton = [self PATaddTextButtonWithTitle:@"SETTINGS"
													  withFont:@"Odin Rounded"
													  withSize:self.view.bounds.size.width*0.05];
	
	[settingsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:settingsButton];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:settingsButton
														  attribute:NSLayoutAttributeTop
														  relatedBy:NSLayoutRelationEqual
															 toItem:timeMachineButton
														  attribute:NSLayoutAttributeTop
														 multiplier:1.0
														   constant:self.view.bounds.size.height*(0.1)]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:settingsButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeLeading
														 multiplier:1.0
														   constant:self.view.bounds.size.width*0.3f]];
	
	[settingsButton addTarget:self
					   action:@selector(showSettingsFurther)
			 forControlEvents:UIControlEventTouchUpInside];
	
}


- (void)showSettingsFurther {
	[self.delegate PATShowSetting];
}


-(UIButton *) PATaddTextButtonWithTitle:(NSString *)title withFont:(NSString *)font withSize:(CGFloat) size {
	
	UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont fontWithName:font size:size];
	
	return button;
}

@end