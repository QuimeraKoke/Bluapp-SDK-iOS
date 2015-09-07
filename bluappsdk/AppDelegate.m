//
//  AppDelegate.m
//  bluappsdk
//
//  Created by Manuel Luque on 14/1/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import "AppDelegate.h"
#import "BluappManage.h"
#import "test.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    /*
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    */
    bluapp= [BluappManage alloc];
    [bluapp startWithCustomerAndDebug:@"charles@falabella.cl" anddebug:TRUE];

    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    [bluapp setToken:[oNSUUID UUIDString]];

    
    return YES;
}

- (void)finishSync:(NSDictionary *)json  andoptions:(int) options {
}

- (void)error:(NSDictionary *)json anderror:(NSError*) error andoptions:(int) options {
}



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSMutableDictionary *r = [[NSMutableDictionary alloc] init];
    
    if ( application.applicationState == UIApplicationStateActive ) {
        [r setObject:@YES forKey:@"show"];
        [r setObject:notification.userInfo forKey:@"userInfo"];
    } else {
        [r setObject:@NO forKey:@"show"];
        [r setObject:notification.userInfo forKey:@"userInfo"];
        [bluapp reciveRemoteNotification:r andshow:FALSE];
    }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

//For interactive notification only
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
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

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *str = [NSString
                     stringWithFormat:@"%@",deviceToken];
    
    NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    if (newString == nil)
        newString = @"";
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    [bluapp setToken:[oNSUUID UUIDString]];
}



@end
