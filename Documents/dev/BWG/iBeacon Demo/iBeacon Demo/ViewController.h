//
//  ViewController.h
//  iBeacon Demo
//
//  Created by Jorge Gutiérrez on 23-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KontaktSDK.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDataSource,KTKLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *beaconsTableView;
@property KTKLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIImageView *sponsor;

@end