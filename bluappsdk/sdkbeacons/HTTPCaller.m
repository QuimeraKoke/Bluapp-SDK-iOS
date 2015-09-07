//
//  syncmanager.m
//  CardapioIOS
//
//  Created by Manuel Luque on 04/10/13.
//  Copyright (c) 2013 Manuel Luque. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "HTTPCaller.h"
#import "synclistener.h"
#import <CoreData/CoreData.h>

@implementation HTTPCaller

- (void)getUIDS:(NSObject<synclistener> *) list  andopt:(int) opt andcustomer:(NSString*) customerid {

    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:customerid forKey:@"customerid"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"getUIDSIOS" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request
								   delegate:self
								   startImmediately:YES];
}

- (void)ChangedBeacons:(NSObject<synclistener> *) list andcustomerid:(NSString*) customerid andopt:(int)opt {

    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
     
     NSMutableString *formPostParams = [[NSMutableString alloc] init];
     NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
     [args setObject:customerid forKey:@"customerid"];
    
     NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
     [dd setObject:@"1" forKey:@"id"];
     [dd setObject:@"beaconsChanged" forKey:@"name"];
     [dd setObject:args forKey:@"args"];
     [dd setObject:@"" forKey:@"session"];
     
     [formPostParams appendString: @"query"];
     [formPostParams appendString: @"="];
     [formPostParams appendString: [self toNSString:dd]];
     [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
     
     NSURLConnection *connection = [[NSURLConnection alloc]
                                    initWithRequest:request
                                    delegate:self
                                    startImmediately:YES];
 }
 
 
- (void)sendPush:(NSObject<synclistener> *) list beaconuuid:(NSString*) beacon andmajor:(int) major andminor:(int) minor andopt:(int)opt andDevice:(NSString*) deviceid andenter:(BOOL) enter {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];

    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:beacon forKey:@"uuid"];
    [args setObject:[NSNumber numberWithInt:major] forKey:@"major"];
    [args setObject:[NSNumber numberWithInt:minor] forKey:@"minor"];
    [args setObject:beacon forKey:@"uuid"];
    if (deviceid == nil || deviceid == [NSNull null] || [deviceid length] == 0) {
        deviceid = @"";
    }
    [args setObject:deviceid forKey:@"deviceid"];
    if (enter)
        [args setObject:@YES forKey:@"enterrange"];
    else
        [args setObject:@NO forKey:@"enterrange"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"getpushnotification" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}

- (void)trackingInfo:(NSObject<synclistener> *) list idcamp:(int) idcamp anddeviceid:(NSString*) deviceid andcontent:(NSString*) content andenter:(BOOL) enter andoption:(int) opt  {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];

    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:[NSNumber numberWithInt:idcamp] forKey:@"idcamp"];
    [args setObject:@"" forKey:@"proximityuuid"];
    [args setObject:[NSNumber numberWithInt:idcamp] forKey:@"major"];
    [args setObject:[NSNumber numberWithInt:idcamp] forKey:@"minor"];
    if (deviceid == nil || deviceid == [NSNull null] || [deviceid length] == 0) {
        deviceid = @"";
    }
    [args setObject:deviceid forKey:@"deviceid"];
    [args setObject:content forKey:@"data"];
    if (enter)
        [args setObject:@YES forKey:@"enter"];
    else
        [args setObject:@NO forKey:@"enter"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"trackingdevice_info" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}



- (void)trackingPush:(NSObject<synclistener> *) list idcamp:(int) idcamp anddeviceid:(NSString*) deviceid andcontent:(NSString*) content andenter:(BOOL) enter andoption:(int) opt  {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:[NSNumber numberWithInt:idcamp] forKey:@"idcamp"];
    [args setObject:@"" forKey:@"proximityuuid"];
    [args setObject:[NSNumber numberWithInt:idcamp] forKey:@"major"];
    [args setObject:[NSNumber numberWithInt:idcamp] forKey:@"minor"];
    if (deviceid == nil || deviceid == [NSNull null] || [deviceid length] == 0) {
        deviceid = @"";
    }
    [args setObject:deviceid forKey:@"deviceid"];
    [args setObject:content forKey:@"data"];
    if (enter)
    [args setObject:@YES forKey:@"enter"];
    else
    [args setObject:@NO forKey:@"enter"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"trackingdevice_push" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}


- (void)trackingRange:(NSObject<synclistener> *) list anduuid:(NSString*) uuid andmajor:(int) major andminor:(int) minor anddeviceid:(NSString*) deviceid andproximity:(NSString*) proximity andenter:(BOOL) enter andoption:(int) opt  {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:uuid forKey:@"proximityuuid"];
    [args setObject:[NSNumber numberWithInt:major] forKey:@"major"];
    [args setObject:[NSNumber numberWithInt:minor] forKey:@"minor"];
    if (deviceid == nil || deviceid == [NSNull null] || [deviceid length] == 0) {
        deviceid = @"";
    }
    [args setObject:deviceid forKey:@"deviceid"];
    [args setObject:proximity forKey:@"proximity"];
    if (enter)
    [args setObject:@YES forKey:@"enter"];
    else
    [args setObject:@NO forKey:@"enter"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"trackingdevice_range" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}



// Solo test
- (void)getBeaconInfo:(NSObject<synclistener> *) list idcampaings:(int) campaing andopt:(int)opt {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    
    
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:[NSNumber numberWithInt:campaing] forKey:@"idcamp"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"getbeaconinfo" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}

// Solo rest
- (void)getBeacon:(NSObject<synclistener> *) list idcampaings:(int) campaing andopt:(int)opt {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    
    
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e" forKey:@"uuid"];
    [args setObject:[NSNumber numberWithInt:49403] forKey:@"major"];
    [args setObject:[NSNumber numberWithInt:50098] forKey:@"minor"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"getbeacon" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}

- (void)getCampain:(NSObject<synclistener> *) list idcampaings:(int) campaing andopt:(int)opt {
    
    NSMutableURLRequest *request = [self getGeneric:list andopt:opt];
    NSMutableString *formPostParams = [[NSMutableString alloc] init];
    
    
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:[NSNumber numberWithInt:10] forKey:@"idbeacon"];
    
    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    [dd setObject:@"1" forKey:@"id"];
    [dd setObject:@"getcampain" forKey:@"name"];
    [dd setObject:args forKey:@"args"];
    [dd setObject:@"" forKey:@"session"];
    [formPostParams appendString: @"query"];
    [formPostParams appendString: @"="];
    [formPostParams appendString: [self toNSString:dd]];
    [request setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
}

- (NSMutableURLRequest*)getGeneric:(NSObject<synclistener> *) list  andopt:(int) opt
{
    listener = list;
    options = opt;
    url  = [[NSURL alloc] initWithString:[HTTPCaller getURL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL: url
                                    cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
                                    timeoutInterval: 10
                                    ];
    [request setHTTPMethod:@"POST"];
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now

    NSError* error;
    NSString *strData = [[NSString alloc]initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:_responseData
                                                         options:kNilOptions
                                                           error:&error];

    [listener finishSync:json  andoptions:options];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"ERRORb %@", error);

    if (listener != nil)
        [listener error:nil anderror:error andoptions:options];
}


- (NSString*)toNSString:(NSMutableDictionary*) myDictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myDictionary
                                                       options:0
                                                         error:&error];
    NSString *str = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    return str;
}


- (BOOL)hasError:(NSMutableDictionary*) json {
    
    if (json == nil)
        return true;
    
    if ([[json allKeys] containsObject:@"error"]) {
        if ([[json objectForKey:@"error"] intValue] == 0)
        return false;
    }
    return true;
}

+ (NSString*)getURL
{
    return @"http://ec2-54-233-70-75.sa-east-1.compute.amazonaws.com:8001/ws/call/";
    //return @"http://192.168.0.2:9100/ws/call/";
}

+ (NSString*)getURLImage
{
    return @"http://190.106.107.83:9100";
    //return @"http://192.168.0.2:9000";
}
@end
