//
//  AppDelegate.h
//  bluappsdk
//
//  Created by Manuel Luque on 14/1/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluappManage.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BluappManage *bluapp;
}

@property (strong, nonatomic) UIWindow *window;
- (NSString*)getToken;


@end

