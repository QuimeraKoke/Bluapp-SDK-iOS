//
//  EmergencyViewController.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 08-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+56942403760"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+56942403760"]];
}
@end
