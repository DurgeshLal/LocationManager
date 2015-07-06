//
//  AppDelegate.h
//  LocationManager
//
//  Created by Durgesh Gupta on 7/6/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, assign) CLLocationCoordinate2D lastLocation;
@property (nonatomic, assign) CLLocationAccuracy accuracyLastLocation;

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, assign) CLLocationAccuracy accuracyLocation;



@end
