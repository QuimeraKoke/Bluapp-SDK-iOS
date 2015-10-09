//
//  AppDelegate.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "AppDelegate.h"

//#import "KontaktSDK.h"

@interface AppDelegate ()
//<KTKLocationManagerDelegate>
//
//@property KTKLocationManager *locationManager;

@end

@implementation AppDelegate

//- (id)init
//{
//    self = [super init];
//    
//    if (self)
//    {
//        _locationManager = [KTKLocationManager new];
//        _locationManager.delegate = self;
//    }
//    
//    return self;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    if ([KTKLocationManager canMonitorBeacons])
//    {
//        KTKRegion *region =[[KTKRegion alloc] init];
//        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
//        
//        [self.locationManager setRegions:@[region]];
//        [self.locationManager startMonitoringBeacons];
//    }
    
    // Override point for customization after application launch.
    
    // None of the code should even be compiled unless the Base SDK is iOS 8.0 or later
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//    // The following line must only run under iOS 8. This runtime check prevents
//    // it from running if it doesn't exist (such as running under iOS 7 or earlier).
//    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
//#endif
    
    
    return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
 
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

//#pragma mark - KTKLocationManagerDelegate
//
//
//- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
//{
//    if (state == KTKLocationManagerStateFailed)
//    {
//        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
//    }
//}
//
//- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
//{
//    NSLog(@"Enter region %@", region.uuid);
//}
//
//- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
//{
//    NSLog(@"Exit region %@", region.uuid);
//}
//
//- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
//{
//    NSLog(@"Ranged beacons count: %lu", [beacons count]);
//}

@end