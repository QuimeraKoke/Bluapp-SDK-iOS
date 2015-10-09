//
//  AppDelegate.m
//  iBeacon Demo
//
//  Created by Jorge Gutiérrez on 23-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (){
    NSMutableArray *StoagedBeacons;
}

//@property KTKLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // None of the code should even be compiled unless the Base SDK is iOS 8.0 or later
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    // The following line must only run under iOS 8. This runtime check prevents
    // it from running if it doesn't exist (such as running under iOS 7 or earlier).
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
#endif
    
//     Override point for customization after application launch.
//    StoagedBeacons=[[NSMutableArray alloc] init];
//    if ([KTKLocationManager canMonitorBeacons])
//    {
//        KTKRegion *region =[[KTKRegion alloc] init];
//        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
//        
//        [self.locationManager setRegions:@[region]];
//        [self.locationManager startMonitoringBeacons];
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//#pragma mark - kontaktSDK
//- (id)init
//{
//    self = [super init];
//    if (self)
//    {
//        _locationManager = [KTKLocationManager new];
//        _locationManager.delegate = self;
//    }
//    return self;
//}
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
//    [StoagedBeacons addObject:region.major];
//    
//}
//
//- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
//{
//    NSLog(@"Exit region %@", region.uuid);
//}
//
//- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
//{
//    if (![StoagedBeacons containsObject:[[beacons objectAtIndex:0] major]]) {
//        [StoagedBeacons addObject:[[beacons objectAtIndex:0] major]];
//    }
//}

@end
