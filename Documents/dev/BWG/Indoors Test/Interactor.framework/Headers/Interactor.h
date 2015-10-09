#import <Foundation/Foundation.h>
#import "LBSEvent.h"
#import "LBSBeacon.h"
#import "LBSConfig.h"
#import "LBSEventContent.h"
#import <UIKit/UIKit.h>

@protocol EventListener

- (void)eventTriggered:(LBSEvent *)data;

@end

@protocol BeaconListener

- (void)didRangeRegion:(LBSBeacon *)beacon distance:(double)distance;

@end


@interface Interactor : NSObject{}

+ (instancetype)sharedInteractor;

/**
 *  Configure the Interactor
 *
 *  Use to configure with individual configuration
 *  @param LBSConfig
 *
 */
- (void)configureWithConfig:(LBSConfig *)config;


/**
 *  Configure the Interactor
 *
 *  @param apiKey API Key for the application, can be found in the web
 *
 */
- (void)configureWithApiKey:(NSString *)apiKey;


/**
 *  Configure the Interactor
 *
 *  @param apiKey API Key for the application, can be found in the web
 *  @param server basis url
 *
 */
- (void)configureWithApiKey:(NSString *)apiKey andServer:(NSString *)server;


/**
 *  Start Interactor Scanning
 *
 */
- (void)startInteractor;

/**
 *  Stop Interactor Scanning
 *
 */
- (void)stopInteractor;

/**
 *  registers an event listener to all events
 *
 *  @param listener instance if Inter
 */
- (void)registerEventListener:(id<EventListener>)listener;

/**
 *  remove an event listener
 *
 *  @param listener
 */
- (void)removeEventListener:(id<EventListener>)listener;

/**
 *  Registers a beacon listener, called if beacon is
 *  seen
 *
 *
 *  @param listener
 *  @param beacon
 */
- (void)registerBeaconListener:(id<BeaconListener>)listener forBeacon:(LBSBeacon *)beacon;

/**
 *  Removes a beacon listener
 *
 *  @param listener
 *  @param beacon
 */
- (void)removeBeaconListener:(id<BeaconListener>)listener forBeacon:(LBSBeacon *)beacon;


/**
 *  Get all Beacon for this Account
 */
- (NSMutableSet*)getAllBeacons;


/**
 *  Get Version Number
 */
+ (NSString *)versionInfo;


/**
 *  Get Running state of Interactor
 *
 *  @returns: true if Interactor is runing/working
 */
- (BOOL)isRunning;


@end


