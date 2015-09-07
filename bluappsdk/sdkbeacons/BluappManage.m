//
//  BluappManage.m
//  bluappsdk
//
//  Created by Manuel Luque on 27/1/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//
#import "BeaconData.h"
#import <CommonCrypto/CommonDigest.h>
#import "BluappManage.h"
#import "HTTPCaller.h"
#import "synclistener.h"
#import "KTKLocationManager.h"
#import "KTKRegion.h"
#import "KontaktSDK.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "AppDelegate.h"
#import "showPushInfo.h"
#import "test.h"

@implementation BluappManage

const int GETUUIDS = 100;
const int SHOWDATA = 102;
const int BEACONSCHANGED = 103;

const int SENDBEACONPUSHENTER = 200;
const int SENDBEACONPUSHEXIT = 201;

const int TRACKING = 300;

const int ACTIVE = 0;
const int PENDING = 1;


bool DEBUG_MODE = false;

- (void)startWithCustomerAndDebug:(NSString*) clid anddebug:(BOOL) debug {
   
    DEBUG_MODE = debug;
    [self startWithCustomer:clid];
}

- (void)startWithCustomer:(NSString*) clid {
    
    customerid = clid;
    caller = [HTTPCaller alloc];
    blocked = [[NSMutableDictionary alloc] init];
    [caller getUIDS:self andopt:GETUUIDS andcustomer:customerid];
    logy = 20;
    queue = [[NSMutableArray alloc] init];
    
    lastenter = [[NSMutableDictionary alloc] init];
    lastexit = [[NSMutableDictionary alloc] init];
    
    [NSTimer scheduledTimerWithTimeInterval:60*5
                                     target:self
                                   selector:@selector(ChangedBeacons:)
                                   userInfo:nil
                                    repeats:YES];

    
    [NSTimer scheduledTimerWithTimeInterval:20
                                     target:self
                                   selector:@selector(ttl_check:)
                                   userInfo:nil
                                    repeats:YES];
    
    
}

- (void)ChangedBeacons:(NSTimer *)theTimer {

    HTTPCaller *mycaller = [HTTPCaller alloc];
    [mycaller ChangedBeacons:self andcustomerid:customerid andopt:BEACONSCHANGED];
}


- (void)ttl_check:(NSTimer *)theTimer {
    
    for (NSString *idc in lastenter) {
        NSMutableDictionary *row = [lastenter objectForKey:idc];
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        [rows addObject:[row objectForKey:@"row"]];
        [self sendNotification:rows andenter:TRUE];
    }
}


- (void)finishSync:(NSMutableDictionary *)json  andoptions:(int) options {
    
    if ([caller hasError:json] == false) {
        if (options == GETUUIDS) {
            
            rawresponse = json;
            beaconrange = [json objectForKey:@"response"];
            [self serializeResponse:beaconrange];
            [self activateInspect];
            
        } else if (options == SHOWDATA) {

            showPushInfo *push = [[showPushInfo alloc] init];
            
            NSMutableArray *data = [json objectForKey:@"response"];
            if ([data count] > 0) {
                
                NSMutableDictionary *r = [data objectAtIndex:0];
                push.data = r;
                push.manager = self;
                [master presentViewController:push animated:FALSE completion:nil];
                [self removeFromQueue:[[r objectForKey:@"id"] intValue]];
                
                HTTPCaller *mycallertrack = [HTTPCaller alloc];
                [mycallertrack trackingInfo:self idcamp:[[r objectForKey:@"id"] intValue] anddeviceid:token andcontent:@"" andenter:TRUE  andoption:TRACKING];
                
            }
            
        } else if (options == BEACONSCHANGED) {
            
            NSMutableDictionary *data = [json objectForKey:@"response"];
            NSString *hash = [data objectForKey:@"hash"];
            NSString *hashold = [[NSUserDefaults standardUserDefaults] objectForKey:@"beaconshash"];
            
            if (hashold == nil || ![hash isEqualToString:hashold]) {
                [self printLog:[NSString stringWithFormat:@"CHANGED HASH IN SERVER NEW %@", hash]];
                caller = [HTTPCaller alloc];
                [caller getUIDS:self andopt:GETUUIDS andcustomer:customerid];
            } else {
                [self printLog:[NSString stringWithFormat:@"NO CHANGED HASH IN SERVER CURRENT %@", hashold]];
            }

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:hash forKey:@"beaconshash"];
            [userDefaults synchronize];

        } else if (options == SENDBEACONPUSHENTER) {
            
            NSMutableDictionary *data = [json objectForKey:@"response"];
            if (data != nil) {
                [self sendNotification:data andenter:TRUE];
            }
            
        } else if (options == SENDBEACONPUSHEXIT) {
            
            NSMutableDictionary *data = [json objectForKey:@"response"];
            if (data != nil) {
                [self sendNotification:data andenter:FALSE];
            }
        }
    } else {
        if (options == GETUUIDS) {
            beaconrange = [self deSerializeResponse];
            [self activateInspect];
        } else if (options == TRACKING) {
            
            NSLog(@"DDDDD %@", json);
        
        }
    }
}

- (void)error:(NSMutableDictionary *)json anderror:(NSError*) error andoptions:(int) options {
    if (options == GETUUIDS) {
        beaconrange = [self deSerializeResponse];
        [self activateInspect];
    }
}

- (void)removeFromQueue:(int) idc {

    for (int idx = 0; idx < [queue count];idx++) {
        NSMutableDictionary *user = [[queue objectAtIndex:idx] objectForKey:@"userInfo"];
        int c = [[[user valueForKey:@"extras"] valueForKey:@"idcampaings"] integerValue];
        if (c == idc) {
            [queue removeObjectAtIndex:idx];
            break;
        }
    }
}

- (void)next {
    if ([queue count] > 0) {
//        [self showPushAlert];
    } else {
        master = nil;
    }
}

- (void)activateInspect {
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound
                                                                                                              categories:nil]];
    }
    initbeaconenter = [[NSMutableArray alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;

    lastenter = [[NSMutableDictionary alloc] init];
    lastexit = [[NSMutableDictionary alloc] init];

    
    NSMutableArray *regions = [[NSMutableArray alloc] init];
    for (int idx = 0; idx < [beaconrange count];idx++) {
        NSMutableDictionary *row = [beaconrange objectAtIndex:idx];

        NSString *proximityUUID = [row objectForKey:@"proximityuuid"];
        int majorv = [[row objectForKey:@"major"] intValue];
        int minorv = [[row objectForKey:@"minor"] intValue];
        
        //proximityUUID = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e";
        NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:proximityUUID];
        NSString *key = [NSMutableString stringWithFormat:@"%@_%i_%i", proximityUUID, majorv, minorv];
        //[beaconskeys addObject:key];
        [self printLog:[NSString stringWithFormat:@"add at region %@", key]];
        NSString *regionIdentifier = key;
        //NSLog(@"DDD %@", regionIdentifier);

        
        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID: beaconUUID major:[[NSNumber numberWithInt:majorv] intValue] minor: [[NSNumber numberWithInt:minorv] intValue] identifier: regionIdentifier ];
        
        beaconRegion.notifyEntryStateOnDisplay = YES;
        beaconRegion.notifyOnEntry = YES;
        beaconRegion.notifyOnExit = YES;
        
        [locationManager startMonitoringForRegion:beaconRegion];
        [locationManager startRangingBeaconsInRegion:beaconRegion];
        
    }
    [locationManager startUpdatingLocation];
    [self printLog:[NSString stringWithFormat:@"startUpdatingLocation "]];

    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [locationManager requestAlwaysAuthorization];
    }
    //[self enterRangeForBeacon:@"F7826DA6-4FA2-4E98-8024-BC5B71E0893E" andmajor:34414 andminor:52045];
}



- (void)locationManager:(CLLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
    }
}

- (void)locationManager:(CLLocationManager *)locationManager didEnterRegion:(CLBeaconRegion *)region
{
    [self printLog:[NSString stringWithFormat:@"Enter to %@", region.identifier]];
    CLBeacon *b = (CLBeacon*)region;
    NSLog(@"DDDDD %@", b);
    [self enterRangeForBeacon:region.proximityUUID.UUIDString andmajor:[region.major intValue] andminor:[region.minor intValue] andproximity:@"near"];
}

- (void)locationManager:(CLLocationManager *)locationManager didExitRegion:(CLBeaconRegion *)region
{
    [self printLog:[NSString stringWithFormat:@"Exit to %@", region.identifier]];
    [self exitRangeForBeacon:region.proximityUUID.UUIDString andmajor:[region.major intValue] andminor:[region.minor intValue] andproximity:@"near"];
}


- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
   //NSLog(@"Enter region %@", region);
   [locationManager requestStateForRegion:region];
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if (state == CLRegionStateInside)
    {
        //Start Ranging
        //[manager startRangingBeaconsInRegion:region];
    }
    else
    {
        //Stop Ranging here
    }
}

- (void)setToken:(NSString*) t {
    token = t;
    [self printLog:[NSString stringWithFormat:@"PUSH TOKEY  %@", token]];
}

-(void)reciveRemoteNotification:(NSMutableDictionary*) userInfo andshow:(BOOL) show {

    NSMutableDictionary *info = [userInfo objectForKey:@"userInfo"];
    int *idcamp = [[[info valueForKey:@"extras"] valueForKey:@"idcampaings"] integerValue];

    HTTPCaller *mycaller = [HTTPCaller alloc];
    [mycaller getBeaconInfo:self idcampaings:idcamp andopt:SHOWDATA];

    
    if (master == nil) {
        UIViewController *current = [UIApplication sharedApplication].keyWindow.rootViewController;
        NSLog(@"current %@", current);
        if ([current isKindOfClass:[UIViewController class]]) {
            master = current;
        }
    }
    return;

}

- (void)showPushAlert {
    
    NSMutableDictionary *data = [queue objectAtIndex:[queue count]-1];
    NSMutableDictionary *userInfo = [data objectForKey:@"userInfo"];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSMutableDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
    
    if ([[data objectForKey:@"show"] boolValue]) {
        NSString *msg = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        int *idcamp = [[[userInfo valueForKey:@"extras"] valueForKey:@"idcampaings"] integerValue];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:prodName message:msg delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Ver", nil];
        alert.tag = idcamp;
        [alert show];
    } else {
        int *idcamp = [[[userInfo valueForKey:@"extras"] valueForKey:@"idcampaings"] integerValue];

        HTTPCaller *mycaller = [HTTPCaller alloc];
        [mycaller getBeaconInfo:self idcampaings:idcamp andopt:SHOWDATA];
        

    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [alertView dismissWithClickedButtonIndex:0 animated:NO];
    if (buttonIndex == 1){
        
        HTTPCaller *mycaller = [HTTPCaller alloc];
        [mycaller getBeaconInfo:self idcampaings:alertView.tag andopt:SHOWDATA];
        
        
    } else {
        if ([queue count] > 0) {
            [self removeFromQueue:alertView.tag];
            [self next];
        }
    }
}


- (void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    //NSLog(@"RANGE HAS %i", [beacons count]);
    //[self printLog:[NSString stringWithFormat:@"RANGE HAS %i", [beacons count]]];


    for (int idx = 0; idx < [beacons count];idx++) {
        CLBeacon *b = (CLBeacon*)[beacons objectAtIndex:idx];
        NSString *current = [NSString stringWithFormat:@"%@_%i_%i", b.proximityUUID.UUIDString, [b.major intValue], [b.minor intValue]];
        
        if (![initbeaconenter containsObject:current]) {
            
            NSLog(@"PROXIMITY %@", b);
            [self enterRangeForBeacon:b.proximityUUID.UUIDString andmajor:[b.major intValue] andminor:[b.minor intValue] andproximity:@"near"];
            [initbeaconenter addObject:current];
        }
        
        /*
        if (![beaconskeys containsObject:current])
            continue;
        
        NSLog(@"beacon  %@", b);
        if ([[blocked allKeys] containsObject:current]) {
            NSMutableDictionary *beacon = [blocked objectForKey:current];
            [beacon setObject:@YES forKey:@"life"];
            if ([[beacon objectForKey:@"status"] intValue] == ACTIVE )
                continue;
            
            [beacon setObject:[NSNumber numberWithInt:ACTIVE] forKey:@"status"];
            [blocked setObject:beacon forKey:current];
            [self enterRange:b andorder:idx];
        } else {
            
            NSMutableDictionary *row = [[NSMutableDictionary alloc] init];
            [row setObject:[NSNumber numberWithInt:ACTIVE] forKey:@"status"];
            [blocked setObject:row forKey:current];
            
            [self enterRange:b andorder:idx];
        }
    }
    // ELIMINAMOS DEL RANGO
    
    // Check exit range.
    for (NSString *key in blocked) {
        BOOL found = false;
        NSMutableDictionary *beacon = [blocked objectForKey:key];
        CLBeacon *b;
        for (int idx = 0; idx < [beacons count];idx++) {
            b = (CLBeacon*)[beacons objectAtIndex:idx];
            NSString *current = [NSString stringWithFormat:@"%@_%i_%i", b.proximityUUID.UUIDString, [b.major intValue], [b.minor intValue]];
            if ([current isEqualToString:key]) {
                found = true;
                break;
            }
        }
        
        NSLog(@"ddddd %i %i", found, [[beacon objectForKey:@"status"] integerValue]);
        if (!found && [[beacon objectForKey:@"status"] integerValue] == ACTIVE ) {
            [beacon setObject:[NSNumber numberWithInt:PENDING] forKey:@"status"];
            NSString *uuid = [self parse:key andtype:@"uuid"];
            int majorv = [[self parse:key andtype:@"major"] intValue];
            int minorv = [[self parse:key andtype:@"minor"] intValue];
            [self exitRange:uuid andorder:-1 andmajor:majorv andminor:minorv];
        }
         */
    }
    
}

- (void)enterRange:(CLBeacon*) b andorder:(int) idx {
    NSString *current = b.proximityUUID.UUIDString;
    HTTPCaller *mycaller = [HTTPCaller alloc];
    int seed = (idx+1)*1000;
    [self printLog:[NSString stringWithFormat:@"enter %@", b.proximityUUID]];
    
    [mycaller sendPush:self beaconuuid:b.proximityUUID.UUIDString andmajor:[b.major intValue] andminor:[b.minor intValue] andopt:seed andDevice:token andenter:TRUE];
}

- (void)enterRangeForBeacon:(NSString*) beaconuuid andmajor:(int) major andminor:(int) minor andproximity:(NSString*) proximity {
    
    HTTPCaller *mycaller = [HTTPCaller alloc];
    [mycaller sendPush:self beaconuuid:beaconuuid andmajor:major andminor:minor andopt:SENDBEACONPUSHENTER andDevice:token andenter:TRUE];

    HTTPCaller *mycallertracking = [HTTPCaller alloc];
    [mycallertracking trackingRange:self anduuid:beaconuuid andmajor:major andminor:minor anddeviceid:token andproximity:proximity andenter:TRUE andoption:TRACKING];

}

- (void)exitRangeForBeacon:(NSString*) beaconuuid andmajor:(int) major andminor:(int) minor andproximity:(NSString*) proximity {
    
    HTTPCaller *mycaller = [HTTPCaller alloc];
    [mycaller sendPush:self beaconuuid:beaconuuid andmajor:major andminor:minor andopt:SENDBEACONPUSHEXIT andDevice:token andenter:FALSE];
    
    HTTPCaller *mycallertracking = [HTTPCaller alloc];
    [mycallertracking trackingRange:self anduuid:beaconuuid andmajor:major andminor:minor anddeviceid:token andproximity:proximity andenter:FALSE andoption:TRACKING];
    
}

- (void)exitRange:(NSString*) b andorder:(int) idx andmajor:(int) major andminor:(int) minor {
    HTTPCaller *mycaller = [HTTPCaller alloc];
    
    int seed = (idx+1)*1000;
    NSLog(@"EXIT");
    [self printLog:[NSString stringWithFormat:@"exit %@", b]];

    [mycaller sendPush:self beaconuuid:b andmajor:major andminor:minor andopt:seed andDevice:token andenter:FALSE];
}

- (void)unBlock:(NSString*) key {
    NSMutableDictionary *r = [blocked objectForKey:key];
    if (r != nil) {
        [r setObject:[NSNumber numberWithInt:PENDING] forKey:@"status"];
    }
}

- (void)serializeResponse:(NSMutableArray*) array {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.data", documentsDirectory, customerid];
    NSLog(@"SAVE TO %@", filePath);
    
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [myData writeToFile:filePath atomically:YES];
}

- (NSMutableArray*)deSerializeResponse{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filenamec = [NSString stringWithFormat:@"%@/%@.data", documentsDirectory, customerid];
    NSLog(@"filenamec value:  %@", filenamec);
    NSData *output1 = [NSData dataWithContentsOfFile:filenamec];
    NSMutableArray* myMutableArray = [NSKeyedUnarchiver
                                      unarchiveObjectWithData:output1];
    
    //NSMutableArray *stuff = [[NSMutableArray alloc] initWithContentsOfFile:filenamec];
    return myMutableArray;
}

- (NSString*)parse:(NSString*) key andtype:(NSString*) type {
    if ([type isEqualToString:@"uuid"]) {
        NSRange range = [key rangeOfString:@"_"];
        return [key substringWithRange:NSMakeRange(0, range.location)];
    } else if ([type isEqualToString:@"major"]) {
        NSRange range = [key rangeOfString:@"_"];
        NSString *key1 = [key substringWithRange:NSMakeRange(range.location+1, [key length] - (range.location+1))];
        NSRange range1 = [key1 rangeOfString:@"_"];
        return [key1 substringWithRange:NSMakeRange(0, range1.location)];
    } else {
        NSRange range = [key rangeOfString:@"_"];
        NSString *key1 = [key substringWithRange:NSMakeRange(range.location+1, [key length] - (range.location+1))];
        NSRange range1 = [key1 rangeOfString:@"_"];
        return [key1 substringWithRange:NSMakeRange(range1.location+1, [key1 length] - (range1.location+1))];
    }
    return @"";
}


-(void)printLog:(NSString*)text {
    
    if (!DEBUG_MODE)
        return;
    
    UIViewController *current = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (logy > 600) {
        for (UIView *a in [[current view] subviews]) {
            if ([a isMemberOfClass:[UILabel class]]) {
                [a removeFromSuperview];
            }
        }
        logy = 20;
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, logy, 400, 10)];
    label.text = text;
    label.font = [UIFont systemFontOfSize:8];
    logy = logy + 10;
    [current.view addSubview:label];
}

- (BOOL)checkTTLEnter:(NSString*) idcamp {
    NSDate *currentDate = [NSDate date];
    long current = floor([currentDate timeIntervalSince1970]);
    NSMutableDictionary *row = [lastenter objectForKey:idcamp];
    double campl = [[row objectForKey:@"nextenter"] doubleValue];
    if (current > campl) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (BOOL)checkTTLExit:(NSString*) idcamp {
    NSDate *currentDate = [NSDate date];
    long current = floor([currentDate timeIntervalSince1970]);
    NSMutableDictionary *row = [lastenter objectForKey:idcamp];
    double campl = [[row objectForKey:@"nextexit"] doubleValue];
    if (current > campl) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)sendNotification:(NSMutableArray*) data andenter:(BOOL) enter {
    NSLog(@"SEND %@", data);
    
    BeaconData *newBeacon = [[BeaconData alloc] init];
    NSMutableDictionary *temp=[data objectAtIndex:0];
    newBeacon.title=[temp objectForKey:@"title"];
    newBeacon.body=[temp objectForKey:@"body"];
    newBeacon.cover=[temp objectForKey:@"cover"];
    newBeacon.type=[temp objectForKey:@"type"];
    newBeacon.url=[temp objectForKey:@"url"];
    if (![[[beaconsInfo lastObject] title] isEqualToString:[newBeacon title]]) {
        [beaconsInfo addObject:newBeacon];
    }
    
    

    for (int idx = 0; idx < [data count];idx++) {
        NSMutableDictionary *row = [data objectAtIndex:idx];
        NSString *text = @"";

        if (enter) {
            text = [row objectForKey:@"msg_enter"];

            if ([[lastenter allKeys] containsObject:[row objectForKey:@"id"]]) {
                NSString *idc = [row objectForKey:@"id"];
                NSMutableDictionary *rowtimer = [row objectForKey:@"id"];
                if (![self checkTTLEnter:idc]) {
                    continue;
                }
            }
            
            if ([[row objectForKey:@"ttl_enter"] intValue] > 0) {
                int ninutes = [[row objectForKey:@"ttl_enter"] intValue];
                NSDate *currentDate = [NSDate date];
                NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:(60*ninutes)];
                NSString *next = [NSString stringWithFormat:@"%.f", floor([datePlusOneMinute timeIntervalSince1970])];
                NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
                [data setObject:next forKey:@"nextenter"];
                [data setObject:row forKey:@"row"];
                [data setObject:@YES forKey:@"isin"];
                [lastenter setObject:data forKey:[row objectForKey:@"id"]];
            }
        
        } else {
            text = [row objectForKey:@"msg_exit"];

            if ([[lastenter allKeys] containsObject:[row objectForKey:@"id"]]) {
                NSString *idc = [row objectForKey:@"id"];
                if (![self checkTTLExit:idc]) {
                    continue;
                }
            }
            
            if ([[row objectForKey:@"ttl_exit"] intValue] > 0) {
                int ninutes = [[row objectForKey:@"ttl_exit"] intValue];
                NSDate *currentDate = [NSDate date];
                NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:(60*ninutes)];
                NSString *next = [NSString stringWithFormat:@"%.f", floor([datePlusOneMinute timeIntervalSince1970])];
                NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
                [data setObject:next forKey:@"nextexit"];
                [data setObject:row forKey:@"row"];
                [data setObject:@YES forKey:@"isin"];
                [data setObject:@NO forKey:@"isin"];

                [lastenter setObject:data forKey:[row objectForKey:@"id"]];
            }
        }
        
        if (text == [NSNull null])
            text = @"";
        
        
        HTTPCaller *mycallerpush = [HTTPCaller alloc];
        [mycallerpush trackingPush:self idcamp:[[row objectForKey:@"id"] intValue]  anddeviceid:token andcontent:@"" andenter:TRUE  andoption:TRACKING];
        
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        //localNotif.fireDate = itemDate;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        // Notification details
        localNotif.alertBody = text;
        // Set the action button
        localNotif.alertAction = @"View";
        
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 0;
        
        // Specify custom data for the notification
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
        int idc = [[row objectForKey:@"id"] intValue];
        NSMutableDictionary *extras = [[NSMutableDictionary alloc] init];
        [extras setObject:[NSNumber numberWithInt:idc] forKey:@"idcampaings"];

        NSMutableDictionary *app = [[NSMutableDictionary alloc] init];
        [app setObject:text forKey:@"alert"];

        [infoDict setObject:extras forKey:@"extras"];
        [infoDict setObject:app forKey:@"aps"];
        
        localNotif.userInfo = infoDict;
        
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];    }
}

@end
