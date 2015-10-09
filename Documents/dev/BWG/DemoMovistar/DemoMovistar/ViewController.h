//
//  ViewController.h
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KontaktSDK.h"

@interface ViewController : UIViewController <KTKLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *continuar;
@property (weak, nonatomic) IBOutlet UILabel *sitio;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property KTKLocationManager *locationManager;
- (IBAction)call:(id)sender;
@end

