//
//  Location.h
//  LocationManager
//
//  Created by Durgesh Gupta on 7/6/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface Location : NSObject

@property (nonatomic, strong) CLLocationManager * locationManager;

+(instancetype)sharedLocation;

@end
