//
//  ViewController.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray *StoagedBeacons;
    BOOL *a;
}

@end

@implementation ViewController
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
- (void)viewDidLoad {
    a=true;
    StoagedBeacons=[[NSMutableArray alloc] init];
    [super viewDidLoad];
    self.label.hidden=YES;
    self.label0.hidden=YES;
    self.continuar.hidden=YES;
    self.nombre.hidden=YES;
    self.sitio.hidden=YES;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSDate *date=[NSDate date];
    [user setObject:date forKey:@"init"];
    [user synchronize];
    // Do any additional setup after loading the view, typically from a nib.
    StoagedBeacons=[[NSMutableArray alloc] init];
    
    [self init];
    if ([KTKLocationManager canMonitorBeacons])
    {
        KTKRegion *region =[[KTKRegion alloc] init];
        
        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
        
        [self.locationManager setRegions:@[region]];
        [self.locationManager startMonitoringBeacons];
    }
    
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
        self.label.hidden=YES;
        self.label0.hidden=YES;
        self.continuar.hidden=YES;
        self.nombre.hidden=YES;
        self.sitio.hidden=YES;
        self.logo.hidden=NO;
        [self reloadInputViews];
    }
    
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    
    
//    [StoagedBeacons addObject:region.minor];
//    NSLog(@"Entre");
//    if ([StoagedBeacons count]==1 && a) {
//        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
//        NSDate *date=[NSDate date];
//        [user setObject:date forKey:@"init"];
//        [user synchronize];
//        a=false;
//    }
//        self.label.hidden=NO;
//        self.label0.hidden=NO;
//        self.continuar.hidden=NO;
//        self.nombre.hidden=NO;
//        self.sitio.hidden=NO;
//        self.logo.hidden=YES;
//    [self reloadInputViews];
    
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
    
//    NSLog(@"%@",region.minor);
//    [StoagedBeacons removeObject:region.minor];
//    NSLog(@"%@",StoagedBeacons);
//    sleep(1);
//    NSLog(@"Salí");
//    if ([StoagedBeacons count]==0) {
//        self.label.hidden=YES;
//        self.label0.hidden=YES;
//        self.continuar.hidden=YES;
//        self.nombre.hidden=YES;
//        self.sitio.hidden=YES;
//        self.logo.hidden=NO;
//        [self reloadInputViews];
//    }
//
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons{
    NSLog(@"Ranged beacons count: %lu", (unsigned long)[beacons count]);
    if ([beacons count]>0) {
        if (a) {
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            NSDate *date=[NSDate date];
            [user setObject:date forKey:@"init"];
            [user synchronize];
            a=false;
            NSLog(@"Hi2");
        }
        self.label.hidden=NO;
        self.label0.hidden=NO;
        self.continuar.hidden=NO;
        self.nombre.hidden=NO;
        self.sitio.hidden=NO;
        self.logo.hidden=YES;
        [self reloadInputViews];
    }
    else{
        self.label.hidden=YES;
        self.label0.hidden=YES;
        self.continuar.hidden=YES;
        self.nombre.hidden=YES;
        self.sitio.hidden=YES;
        self.logo.hidden=NO;
        [self reloadInputViews];

        
    }

}



- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+56942403760"]];
    
}
@end
