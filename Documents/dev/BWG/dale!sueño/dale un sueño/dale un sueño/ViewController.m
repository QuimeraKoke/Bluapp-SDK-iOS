//
//  ViewController.m
//  dale un sueño
//
//  Created by Jorge Gutiérrez on 13-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ViewController.h"
#import "DescripcionViewController.h"
#import "Niño.h"
#import "izqCell.h"
#import "derCell.h"
#import "firstCell.h"

@interface ViewController (){
    NSMutableArray *ninos;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ninos=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80.f;
//}


-(void)viewWillAppear:(BOOL)animated{
    [ninos removeAllObjects];
    NSString *lookup=[NSString stringWithFormat:@"http://52.4.83.159:8030/deseo"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:lookup]];
    [request setHTTPMethod:@"GET"];
    NSError *error = nil; NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSMutableArray *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    for (int i=0;i<[jsonDict count];i++){
        Nin_o *a=[[Nin_o alloc] init];
        a.name=[[jsonDict objectAtIndex:i] objectForKey:@"nombre"];
        a.full_name=[NSString stringWithFormat:@"%@ %@",[[jsonDict objectAtIndex:i] objectForKey:@"nombre"],[[jsonDict objectAtIndex:i] objectForKey:@"apellido"]];
        a.data=[[jsonDict objectAtIndex:i] objectForKey:@"descripcion"];
        a.dream=[[jsonDict objectAtIndex:i] objectForKey:@"deseo"];
        a.imglink=[[jsonDict objectAtIndex:i] objectForKey:@"foto"];
        [ninos addObject:a];
    }
    [self.dreamsTableView reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ninos.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Nin_o *nino=[Nin_o alloc];
    if (indexPath.row%2==1){
        static NSString *simpleTableIdentifier = @"Cellder";
        derCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        nino=[ninos objectAtIndex:indexPath.row];
        cell.name.text=[[nino name] uppercaseString];
        cell.dream.text =[nino dream];
        cell.avatar.image=[UIImage imageNamed:[nino imglink]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        static NSString *simpleTableIdentifier = @"Cellizq";
        izqCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        nino=[ninos objectAtIndex:indexPath.row];
        cell.avatar.image=[UIImage imageNamed:[nino imglink]];
        cell.name.text=[[nino name] uppercaseString];
        cell.dream.text =[nino dream];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Segue to open a dialog
    NSIndexPath *indexPath = [self.dreamsTableView indexPathForSelectedRow];
        Nin_o *n =  [ninos objectAtIndex:indexPath.row];
        DescripcionViewController *destViewController = segue.destinationViewController;
        destViewController.child=n;
}


@end
