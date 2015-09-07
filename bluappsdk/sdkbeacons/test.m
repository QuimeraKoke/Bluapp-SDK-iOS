//
//  test.m
//  bluappsdk
//
//  Created by Manuel Luque on 8/2/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "test.h"
#import "KontaktSDK.h"


@implementation test


- (void)startA {
    
    self.locationManager = [KTKLocationManager new];
    self.locationManager.delegate = self;
    
    if ([KTKLocationManager canMonitorBeacons])
    {
        KTKRegion *region =[[KTKRegion alloc] init];
        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
        
        NSString *proximityUUID = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e";
        NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:proximityUUID];

        
        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID: beaconUUID  identifier: @"" ];
        beaconRegion.notifyEntryStateOnDisplay = YES;
        beaconRegion.notifyOnEntry = YES;
        beaconRegion.notifyOnExit = YES;

        [self.locationManager setRegions:@[region]];
        [self.locationManager startMonitoringBeacons];
        NSLog(@"setup region %@", region.uuid);

    }
    
    // Do any additional setup after loading the view.
}

- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
    }
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    NSLog(@"Enter region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
    NSLog(@"Exit region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
{
    NSLog(@"Ranged beacons count: %lu", [beacons count]);
}


@end
