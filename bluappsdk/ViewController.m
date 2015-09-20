//
//  ViewController.m
//  bluappsdk
//
//  Created by Manuel Luque on 14/1/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

/*
*    http://stackoverflow.com/questions/22833198/get-advertisement-data-for-ble-in-ios
*/

@implementation ViewController

#define BLUNO_TRANSFER_SERVICE_UUID         @"0xDFB0"
#define BLUNO_TRANSFER_CHARACTERISTIC_UUID  @"0xDFB2"

@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
