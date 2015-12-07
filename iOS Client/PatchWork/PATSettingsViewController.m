//
//  PATSideMenuSettingViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 12. 8..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATSettingsViewController.h"

@implementation PATSettingsViewController

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
	
	
	
	// Logout Button
	UIButton* logOutButton = [self PATaddTextButtonWithTitle:@"LOG OUT"
														 withFont:@"Odin Rounded"
														 withSize:self.view.bounds.size.width*0.05];
	
	[logOutButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:logOutButton];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:logOutButton
														  attribute:NSLayoutAttributeCenterY
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeBaseline
														 multiplier:1.0
														   constant:self.view.bounds.size.height*0.1f]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:logOutButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeLeading
														 multiplier:1.0
														   constant:self.view.bounds.size.width*0.3f]];
	
	// About Button
	UIButton* aboutButton = [self PATaddTextButtonWithTitle:@"ABOUT"
													withFont:@"Odin Rounded"
													withSize:self.view.bounds.size.width*0.05];
	
	[aboutButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:aboutButton];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:aboutButton
														  attribute:NSLayoutAttributeCenterY
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeBaseline
														 multiplier:1.0
														   constant:self.view.bounds.size.height*(-0.1f)]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:aboutButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeLeading
														 multiplier:1.0
														   constant:self.view.bounds.size.width*0.3f]];

	
	
}

@end
