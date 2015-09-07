//
//  showPushInfo.h
//  bluappsdk
//
//  Created by Manuel Luque on 8/2/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluappManage.h"

@interface showPushInfo : UIViewController

@property (nonatomic, retain) BluappManage *manager;

@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) NSMutableDictionary *data;

@end
