//
//  DescripcionViewController.m
//  dale un sueño
//
//  Created by Jorge Gutiérrez on 13-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "DescripcionViewController.h"
#import "ContactoViewController.h"

@interface DescripcionViewController ()

@end

@implementation DescripcionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descripcion.layer.borderWidth = 0.5f;
    self.descripcion.layer.borderColor = [[self colorWithHexString:@"F9A10B"] CGColor];
    self.descripcion.layer.cornerRadius = 5.0f;
    [self.descripcion setFont:[UIFont systemFontOfSize:16]];
    [self.dream sizeToFit];
    [self.descripcion sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.name.text=[[self.child full_name] uppercaseString];
    [self.dream setText:[NSString stringWithFormat:@"%@\t\t\t\t\t\t\t\t\t",[self.child dream]]];
    self.descripcion.text=[self.child data];
    self.avatar.image=[UIImage imageNamed:[self.child imglink]];
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Segue to open a dialog
     if ([segue.identifier isEqualToString:@"go1"]) {
         ContactoViewController *destViewController = segue.destinationViewController;
         destViewController.childo=self.child;
     }
 }
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
