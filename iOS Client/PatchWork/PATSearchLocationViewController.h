//
//  PATSearchLocationViewController.h
//  PatchWork
//
//  Created by BgKim on 2015. 12. 16..
//  Copyright © 2015년 NEXT Institute. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol cameraToAnotherPlace
-(void) PATCameraToPlaceAtLatitude:(double)latitude withLongitude:(double)longitude;
@end

@protocol backToContainerFromSearchLocation
- (void) PATBackToGoogleMap;
@end


@interface PATSearchLocationViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<cameraToAnotherPlace, backToContainerFromSearchLocation> delegate;
@property (nonatomic) UITextField* inputTextField;
@property (nonatomic) BOOL willShowKeyboard;
@property (nonatomic) UITableView* predictedPlaceTable;

@end

