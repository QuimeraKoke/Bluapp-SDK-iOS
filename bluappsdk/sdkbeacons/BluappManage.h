//
//  BluappManage.h
//  bluappsdk
//
//  Created by Manuel Luque on 27/1/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPCaller.h"
#import "synclistener.h"
#import <CoreLocation/CoreLocation.h>

@interface BluappManage : NSObject<synclistener,CLLocationManagerDelegate,UIApplicationDelegate> {

    HTTPCaller *caller;
    NSString *customerid;
    NSMutableArray *beaconrange;
    CLLocationManager *locationManager;
    NSMutableDictionary *blocked;
    NSString *token;
    UIViewController *master;
    NSMutableArray *queue;
    NSMutableArray *initbeaconenter;
    NSMutableDictionary *rawresponse;
    int logy;
    NSMutableDictionary *lastenter;
    NSMutableDictionary *lastexit;
    
}

- (void)startWithCustomer:(NSMutableArray*) range;
- (void)setToken:(NSString*) t;
- (void)reciveRemoteNotification:(NSDictionary*) userInfo andshow:(BOOL) show;
- (void)next;
- (void)startWithCustomerAndDebug:(NSString*) clid anddebug:(BOOL) debug;

@end
