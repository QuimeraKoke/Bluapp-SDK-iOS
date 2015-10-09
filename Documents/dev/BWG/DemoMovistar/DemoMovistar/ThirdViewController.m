//
//  ThirdViewController.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ThirdViewController.h"
#import "CustomCell.h"
#import "Task.h"
@interface ThirdViewController (){
    NSMutableArray *StoagedBeacons;
}

@property (assign, nonatomic) BOOL celdaAbierta;
@property  NSMutableArray *status;
@property  NSMutableArray *pics;
@property  NSMutableArray *tasks;
@end
@implementation ThirdViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.continuar.hidden=YES;
    self.table.hidden=YES;
    _status=[[NSMutableArray alloc] initWithArray:@[@"delete-icon.png",@"delete-icon.png",@"delete-icon.png",@"delete-icon.png",@"delete-icon.png"]];
    _pics=[[NSMutableArray alloc] initWithArray:@[@"a",@"a",@"a",@"a",@"a"]];
    _tasks=[[NSMutableArray alloc] initWithArray:@[@"Cortar Pasto",@"Revisar Reja",@"Revisar Puertas",@"Limpiar Racks",@"Sensor de Temperatura"]];
    _celdaAbierta = NO;
    self.continuar.hidden=YES;
    // Do any additional setup after loading the view.
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath*)indexPath
{
    if ([indexPath isEqual:_expandIndexPath] && _celdaAbierta){
        return 200;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"Cell";
    CustomCell *cell=[self.table dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    NSLog(@"%@",_status);
    if ([[_status objectAtIndex:indexPath.row] isEqualToString:@"delete-icon.png"]) {
        if ([indexPath isEqual:_expandIndexPath] &&     _celdaAbierta){
            NSLog(@"Aqui");
            cell.alternative.hidden=NO;
            cell.pic.hidden=NO;
            cell.button1.hidden=YES;
            cell.button2.hidden=YES;
            cell.button3.hidden=YES;
            cell.button4.hidden=YES;
        }
        else{
            cell.alternative.hidden=YES;
            cell.pic.hidden=YES;
            cell.button1.hidden=YES;
            cell.button2.hidden=YES;
            cell.button3.hidden=YES;
            cell.button4.hidden=YES;
        }
    }
    if ([[_status objectAtIndex:indexPath.row] isEqualToString:@"Check-icon.png"]) {
        NSLog(@"Aca");
        NSLog(@"%ld",(long)indexPath.row);
        //        cell.userInteractionEnabled = NO;
        cell.alternative.hidden=YES;
        cell.pic.hidden=YES;
        cell.button1.hidden=YES;
        cell.button2.hidden=YES;
        cell.button3.hidden=YES;
        cell.button4.hidden=YES;
    }
    if ([[_pics objectAtIndex:indexPath.row] class] ==[UIImage class]) {
        [cell.pic setImage:[[_pics objectAtIndex:indexPath.row] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    cell.state.image=[UIImage imageNamed:[_status objectAtIndex:indexPath.row]];
    cell.task.text=[_tasks objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)[indexPath row]);
    NSMutableArray *modifiedRows = [NSMutableArray array];
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    _expandIndexPath = indexPath;
    _celdaAbierta = !_celdaAbierta;
    [modifiedRows addObject:indexPath];
    // This will animate updating the row sizes
    [tableView reloadRowsAtIndexPaths:modifiedRows withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)pic:(id)sender {
    NSLog(@"%ld",(long)self.table.indexPathForSelectedRow.row);
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [_pics replaceObjectAtIndex:_expandIndexPath.row withObject:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [_status replaceObjectAtIndex:_expandIndexPath.row withObject:@"Check-icon.png"];
    _celdaAbierta = !_celdaAbierta;
    if ([self howMany:_status]) {
        self.continuar.hidden=NO;
    }
    [self reloadInputViews];
    [self.table reloadData];
    [self.table reloadInputViews];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)done:(id)sender {
    NSLog(@"%ld",(long)self.table.indexPathForSelectedRow.row);
    [_status replaceObjectAtIndex:_expandIndexPath.row withObject:@"Check-icon.png"];
    _celdaAbierta = !_celdaAbierta;
    if ([self howMany:_status]) {
        self.continuar.hidden=NO;
    }
    [self reloadInputViews];
    [self.table reloadData];
    [self.table reloadInputViews];
}
-(BOOL)howMany: (NSMutableArray *)array{
    int c=0;
    for (int i=0; i<[array count]; i++) {
        if ([[array objectAtIndex:i] isEqualToString:@"Check-icon.png"]){
            c++;
        }
    }
    if (c==[array count]) {
        return YES;
    }
    else{
        return NO;
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


#pragma mark - kontaktSDK

- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
        self.table.hidden=NO;
    }
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    NSLog(@"Enter region %@", region.uuid);
    //    if (![StoagedBeacons containsObject:region.major]) {
    //        [StoagedBeacons addObject:region.major];
    //        self.table.hidden=NO;
    //    }
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
    NSLog(@"Exit region %@", region.uuid);
    //    [StoagedBeacons removeAllObjects];
    //    self.table.hidden=YES;
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons{
    if ([beacons count]>0) {
        self.table.hidden=NO;
    }
    else{
        self.table.hidden=YES;
    }
}


@end
