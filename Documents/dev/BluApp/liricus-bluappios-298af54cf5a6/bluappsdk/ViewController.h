//
//  ViewController.h
//  bluappsdk
//
//  Created by Manuel Luque on 14/1/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KontaktSDK.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

@interface ViewController : UIViewController<KTKLocationManagerDelegate> {
    CBCentralManager *CM;
}

@property KTKLocationManager *locationManager;

@end

