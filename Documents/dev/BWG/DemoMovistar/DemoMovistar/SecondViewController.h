//
//  SecondViewController.h
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KontaktSDK.h"

@interface SecondViewController : UIViewController <KTKLocationManagerDelegate>
@property KTKLocationManager *locationManager;
- (IBAction)call:(id)sender;
- (IBAction)continue:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *box1;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *box2;
@property (weak, nonatomic) IBOutlet UIView *box3;
@property (weak, nonatomic) IBOutlet UIButton *continuar;
- (IBAction)open:(id)sender;

@end
