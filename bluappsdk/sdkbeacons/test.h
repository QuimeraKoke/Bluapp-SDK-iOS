//
//  test.h
//  bluappsdk
//
//  Created by Manuel Luque on 8/2/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import <UIKit/UIKit.h>
#import "KontaktSDK.h"

@interface test : NSObject


@property KTKLocationManager *locationManager;

- (void)startA;

@end
