//
//  syncmanager.h
//  CardapioIOS
//
//  Created by Manuel Luque on 04/10/13.
//  Copyright (c) 2013 Manuel Luque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "synclistener.h"

@interface HTTPCaller : NSObject <NSURLConnectionDelegate, synclistener>
{
    int options;
    NSURL *url;
    NSMutableData *_responseData;
    NSObject<synclistener> *listener;
    
    UILabel *uimessage;
    
    NSString *table;
    
}

+ (NSString*)getURL;
+ (NSString*)getURLImage;
- (void)getUIDS:(NSObject<synclistener> *) list  andopt:(int) opt andcustomer:(NSString*) customerid;
- (BOOL)hasError:(NSMutableDictionary*) json;
- (void)sendPush:(NSObject<synclistener> *) list beaconuuid:(NSString*) beacon andmajor:(int) major andminor:(int) minor andopt:(int)opt andDevice:(NSString*) deviceid andenter:(BOOL) enter;
- (void)getBeaconInfo:(NSObject<synclistener> *) list idcampaings:(int) campaing andopt:(int)opt;
- (void)getBeacon:(NSObject<synclistener> *) list idcampaings:(int) campaing andopt:(int)opt;
- (void)getCampain:(NSObject<synclistener> *) list idcampaings:(int) campaing andopt:(int)opt;
- (void)ChangedBeacons:(NSObject<synclistener> *) list andcustomerid:(NSString*) customerid andopt:(int)opt;
- (void)trackingInfo:(NSObject<synclistener> *) list idcamp:(int) idcamp anddeviceid:(NSString*) deviceid andcontent:(NSString*) content andenter:(BOOL) enter andoption:(int) opt ;
- (void)trackingPush:(NSObject<synclistener> *) list idcamp:(int) idcamp anddeviceid:(NSString*) deviceid andcontent:(NSString*) content andenter:(BOOL) enter andoption:(int) opt;
- (void)trackingRange:(NSObject<synclistener> *) list anduuid:(NSString*) uuid andmajor:(int) major andminor:(int) minor anddeviceid:(NSString*) deviceid andproximity:(NSString*) proximity andenter:(BOOL) enter andoption:(int) opt;
@end
