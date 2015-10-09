//
//  SecondViewController.h
//  iBeacon Demo
//
//  Created by Jorge Gutiérrez on 14-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UITextView *descripcion;
@property NSString *img;
@property NSString *des;

@end
