//
//  Task.h
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 31-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Task : NSObject
@property NSInteger *state;
@property UIImage* pic;
@property NSString *solution;
@property NSString *title;
@property NSInteger *activated;



@end
