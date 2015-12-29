//
//  PATTimeMachineViewController.m
//  PatchWork
//
//  Created by BgKim on 2015. 12. 23..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import "PATTimeMachineViewController.h"

@interface PATTimeMachineViewController () {
    NSArray * _pickerData;
}

@end

@implementation PATTimeMachineViewController


- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithWhite:1. alpha:0.];
    
    // 데이터 초기화
    _pickerData = @[@"1 Month\nAgo", @"1 Week\nAgo", @"1 Day\nAgo", @"12 hours\nAgo", @"Now"];
    
    // 데이터 연결
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    // 로드됐을 때 처음 보여질 row 설정
    [self.pickerView selectRow:(_pickerData.count-1) inComponent:0 animated:YES];
    
    // selected row indicator 제거
    [[self.pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[self.pickerView.subviews objectAtIndex:2] setHidden:TRUE];
}





// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickerData.count;
}



// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}




- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // line-break를 위한 설정
    NSString* title = [_pickerData objectAtIndex:row];
    CGRect labelRect = CGRectMake(0, 0, 100., 70.);
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    [label setFont:[UIFont fontWithName:@"Odin Rounded" size:17.0]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setNumberOfLines:2];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    
    return label;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 83.;
}


// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    [quantityPickerDelegate didChangeLabelText:[pickerArray objectAtIndex:row]];// delegate passing the selected value
//    [pickerView reloadComponent:component]; //This will cause your viewForComp to hit
//    
    NSLog(@"%@", [_pickerData objectAtIndex:row]);
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

@end