//
//  BeaconData.h
//  bluappsdk
//
//  Created by Jorge Gutiérrez on 04-09-15.
//
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BeaconData : NSObject
@property(copy,nonatomic) NSString *title;
@property(copy,nonatomic) NSString *type;
@property(copy,nonatomic) UIImage *cover;
@property(copy,nonatomic) NSString *url;
@property(copy,nonatomic)  NSString *body;

@end
