//
//  synclistener.h
//  CardapioIOS
//
//  Created by Manuel Luque on 07/10/13.
//  Copyright (c) 2013 Manuel Luque. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol synclistener <NSObject>

- (void)finishSync:(NSMutableDictionary *)json  andoptions:(int) options;
- (void)error:(NSMutableDictionary *)json anderror:(NSError*) error andoptions:(int) options;

@end 