//
//  CustomCell.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 08-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize task=_task;
@synthesize state=_state;
@synthesize button1=_button1;
@synthesize button2=_button2;
@synthesize button3=_button3;
@synthesize button4=_button4;
@synthesize pic=_pic;
@synthesize alternative=_alternative;

- (void)awakeFromNib {
    // Initialization code
    self.button1.hidden=YES;
    self.button2.hidden=YES;
    self.button3.hidden=YES;
    self.button4.hidden=YES;
    self.pic.hidden=YES;
    self.alternative.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)show:(id)sender {
    self.button1.hidden=NO;
    self.button2.hidden=NO;
    self.button3.hidden=NO;
    self.button4.hidden=NO;
    self.pic.hidden=YES;
    self.alternative.hidden=YES;
}


- (IBAction)call:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+56942403760"]];
}
@end
