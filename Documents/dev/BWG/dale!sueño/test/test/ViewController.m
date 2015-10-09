//
//  ViewController.m
//  test
//
//  Created by Jorge Gutiérrez on 16-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)assds:(id)sender {
    NSURL *whatsappURL = [NSURL URLWithString:@"whatsapp://send?text=Hello%2C%20World!&abid=10"];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }

}
@end
