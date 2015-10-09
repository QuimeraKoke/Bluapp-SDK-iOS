//
//  CustomCell.h
//  iBeacon Demo
//
//  Created by Jorge Gutiérrez on 23-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *body;


@end
