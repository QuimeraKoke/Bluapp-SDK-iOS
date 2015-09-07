//
//  synclistener.m
//  CardapioIOS
//
//  Created by Manuel Luque on 07/10/13.
//  Copyright (c) 2013 Manuel Luque. All rights reserved.
//

#import "synclistener.h"

@protocol synclistener

- (void)finishSync:(NSMutableDictionary *)json  andoptions:(int) options;
- (void)error:(NSMutableDictionary *)json anderror:(NSError*) error andoptions:(int) options;

@end
