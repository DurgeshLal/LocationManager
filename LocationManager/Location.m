//
//  LocationShareModel.m
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import "Location.h"

@implementation Location

+ (instancetype)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceQueue;
    static Location *sharedLocation = nil;
    dispatch_once(&onceQueue, ^{
        
        if (sharedLocation == nil) {
            sharedLocation = [super allocWithZone:zone];
        }
    });
    
    return sharedLocation;
}

+(instancetype)sharedLocation{
    
    static dispatch_once_t once = 0;
    static Location *sharedLocation;
    
    if (sharedLocation) {
        return sharedLocation;
    }
    
    dispatch_once(&once, ^{
        
        if (!sharedLocation) {
            sharedLocation = [[Location alloc]init];
        }
    });
    
    return sharedLocation;
}


@end
