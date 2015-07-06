//
//  AppDelegate.m
//  LocationManager
//
//  Created by Durgesh Gupta on 7/6/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#define kEnableBackgroundAppRefresh  @"Enable Background App Refresh"
#define kEnableFetch @"Enable Background Refresh : Settings > General > Background App Refresh"

#import "AppDelegate.h"
#import "Location.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSLog(@"backgroundRefreshStatus -->%ld",(long)[[UIApplication sharedApplication] backgroundRefreshStatus]);
    
    switch ([[UIApplication sharedApplication] backgroundRefreshStatus]) {
        case 0:
        {
            
            if (IS_OS_8_OR_ABOVE) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:kEnableBackgroundAppRefresh preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * __nonnull action) {
                    
                }];
                [alertController addAction:action];
                [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
                    
                }];
                
            }else{
                // Depricated as of iOS 9.0
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:kEnableBackgroundAppRefresh delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
            break;
            
            // is background fetch enabled?
        case 1:
        {
            if (IS_OS_8_OR_ABOVE) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:kEnableFetch preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * __nonnull action) {
                    
                }];
                [alertController addAction:action];
                [self.window.rootViewController presentViewController:alertController animated:YES completion:^{
                    
                }];
                
            }else{
                // Depricated as of iOS 9.0
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:kEnableFetch delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
            break;
            
            // Is significant change in Location?
            // When the app is receiving the key, it must reinitiate the locationManager and get current location
            // This UIApplicationLaunchOptionsLocationKey key enables the location update even when
            // the app has been killed/terminated (Not in th background) by iOS or the user.
            
            
        default:
        {
            if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
                NSLog(@"UIApplicationLaunchOptionsLocationKey");
                
                // This "isResumed" flag is just to show that it is receiving location updates
                
                [Location sharedLocation].locationManager = [CLLocationManager new];
                [Location sharedLocation].locationManager.delegate = self;
                [Location sharedLocation].locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
                [Location sharedLocation].locationManager.activityType = CLActivityTypeOtherNavigation;
                
                if(IS_OS_8_OR_ABOVE) {
                    [[Location sharedLocation].locationManager requestAlwaysAuthorization];
                }
                
                [[Location sharedLocation].locationManager startMonitoringSignificantLocationChanges];
                
            }
            
        }
            break;
    }
    
    
    return YES;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"Updating Location %@",locations);
    
    for(int index = 0;index < locations.count; index++){
        
        CLLocation * newLocation = locations[index];
        CLLocationCoordinate2D location = newLocation.coordinate;
        CLLocationAccuracy accuracy = newLocation.horizontalAccuracy;
        
        self.location = location;
        self.accuracyLocation = accuracy;
    }
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
    //[[Location sharedLocation].locationManager stopMonitoringSignificantLocationChanges];
    
    if(IS_OS_8_OR_ABOVE) {
        
        if ([[Location sharedLocation].locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [[Location sharedLocation].locationManager requestWhenInUseAuthorization];
        }
    }
    //[[Location sharedLocation].locationManager startMonitoringSignificantLocationChanges];
    
    [Location sharedLocation].locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    
    
    //Remove the "isResumed" Flag after the app is active again.
    
    if([Location sharedLocation].locationManager)
        [[Location sharedLocation].locationManager stopMonitoringSignificantLocationChanges];
    
    [Location sharedLocation].locationManager = [CLLocationManager new];
    [Location sharedLocation].locationManager.delegate = self;
    [Location sharedLocation].locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [Location sharedLocation].locationManager.activityType = CLActivityTypeOtherNavigation;
    
    if(IS_OS_8_OR_ABOVE) {
        [[Location sharedLocation].locationManager requestAlwaysAuthorization];
    }
    [[Location sharedLocation].locationManager startMonitoringSignificantLocationChanges];
}


-(void)applicationWillTerminate:(UIApplication *)application{
    NSLog(@"applicationWillTerminate");
}

@end

