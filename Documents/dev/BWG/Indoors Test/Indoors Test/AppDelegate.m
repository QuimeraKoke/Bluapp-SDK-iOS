//
//  AppDelegate.m
//  Indoors Test
//
//  Created by Jorge Gutiérrez on 10-09-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.

//

#import "AppDelegate.h"
@import Foundation;
#import <Interactor/Interactor.h>

//#define NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"];
@interface AppDelegate ()<EventListener,BeaconListener>{
    Interactor *interactor;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    // The following line must only run under iOS 8. This runtime check prevents
    // it from running if it doesn't exist (such as running under iOS 7 or earlier).
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
#endif

    // Override point for customization after application launch.
    LBSConfig * config = [[LBSConfig alloc]init];
    config.server = @"https://interactor.swisscom.ch";
    config.apiKey = @"207d3708-6e2f-4ae9-84d7-9cad152a73fa";
    config.logging = NO;
    NSUUID *uuid=[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"];
    [[Interactor sharedInteractor] configureWithConfig:config];
    [[Interactor sharedInteractor] registerBeaconListener:self forBeacon:[LBSBeacon initWithWithUUID:uuid major:50547 minor:18839]];
    [[Interactor sharedInteractor] registerEventListener: self];
    [[Interactor sharedInteractor] startInteractor];
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:[UIUserNotificationSettings
                                       settingsForTypes:UIUserNotificationTypeAlert
                                       categories:nil]];
    

   return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BWG"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
       [alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)eventTriggered:(LBSEvent *)data{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.alertTitle=@"Notificacion";
    localNotification.alertBody= @"Welcome to UP!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    NSLog(@"%@",data.description);
}
-(void)didRangeRegion:(LBSBeacon *)beacon distance:(double)distance{
    NSMutableSet * beacons = [interactor getAllBeacons];
    for (LBSBeacon * beacon in beacons) {
        NSLog(@"%ld",(long)beacon.major);
        [[Interactor sharedInteractor] registerBeaconListener:nil forBeacon: beacon];
    }
}
@end