//
//  BeaconData.h
//  iBeacon Demo
//
//  Created by Jorge Gutiérrez on 23-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconData : NSObject
@property (copy,nonatomic) NSString *titulo;
@property (copy,nonatomic) NSString *imagen;
@property (copy,nonatomic,) NSString *cuerpo;
@property (copy,nonatomic) NSString *full_info;
@end
