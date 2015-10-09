//
//  ThirdViewController.h
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KontaktSDK.h"

@interface ThirdViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,KTKLocationManagerDelegate >
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic) NSIndexPath *expandIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *continuar;
@property KTKLocationManager *locationManager;

- (IBAction)pic:(id)sender;
- (IBAction)done:(id)sender;

@end
