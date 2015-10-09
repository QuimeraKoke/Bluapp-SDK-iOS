//
//  CustomCell.h
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 08-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *task;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *pic;
@property (weak, nonatomic) IBOutlet UIImageView *state;
@property (weak, nonatomic) IBOutlet UIButton *alternative;

- (IBAction)show:(id)sender;
- (IBAction)call:(id)sender;





@end
