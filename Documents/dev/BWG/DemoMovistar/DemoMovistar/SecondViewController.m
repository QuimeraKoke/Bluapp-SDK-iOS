//
//  SecondViewController.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){
    NSMutableArray *StoagedBeacons;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.box1.hidden=YES;
    self.box2.hidden=YES;
    self.box3.hidden=YES;
    self.continuar.hidden=YES;
    
    StoagedBeacons=[[NSMutableArray alloc] init];
    [self init];
    if ([KTKLocationManager canMonitorBeacons])
    {
        KTKRegion *region =[[KTKRegion alloc] init];
        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
        
        [self.locationManager setRegions:@[region]];
        [self.locationManager startMonitoringBeacons];
    }
    // Do any additional setup after loading the view.
    self.label.hidden=YES;
    self.box1.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - kontaktSDK

- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
        self.box1.hidden=YES;
        self.box2.hidden=YES;
        self.continuar.hidden=YES;
        self.label.hidden=YES;
        self.box3.hidden=YES;
        [self reloadInputViews];
    }
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _locationManager = [KTKLocationManager new];
        _locationManager.delegate = self;
    }
    
    return self;
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    NSLog(@"Enter region %@", region.uuid);
//    if (![StoagedBeacons containsObject:region.major]) {
//        [StoagedBeacons addObject:region.major];
//        self.box1.hidden=NO;
//        self.box2.hidden=NO;
//        self.continuar.hidden=NO;
//        self.label.hidden=NO;
//        self.box3.hidden=NO;
//    }
    
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons{
    NSLog(@"Ranged beacons count: %lu", (unsigned long)[beacons count]);
    if ([beacons count]>0) {
        self.box1.hidden=NO;
        self.box2.hidden=NO;
        self.continuar.hidden=NO;
        self.label.hidden=NO;
        self.box3.hidden=NO;
        [self reloadInputViews];
    }
    else{
        self.box1.hidden=YES;
        self.box2.hidden=YES;
        self.continuar.hidden=YES;
        self.label.hidden=YES;
        self.box3.hidden=YES;
        [self reloadInputViews];
    }
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

- (IBAction)continue:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}
- (IBAction)open:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}
@end
