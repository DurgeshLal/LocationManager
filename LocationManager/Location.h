//
//  LocationShareModel.h
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface Location : NSObject

@property (nonatomic, strong) CLLocationManager * locationManager;

+(instancetype)sharedLocation;

@end
