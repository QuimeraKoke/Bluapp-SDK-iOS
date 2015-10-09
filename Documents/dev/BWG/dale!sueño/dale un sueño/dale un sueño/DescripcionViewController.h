//
//  DescripcionViewController.h
//  dale un sueño
//
//  Created by Jorge Gutiérrez on 13-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Niño.h"

@interface DescripcionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sueño;
@property (weak, nonatomic) IBOutlet UITextView *descripcion;
@property (weak, nonatomic) IBOutlet UILabel *dream;


@property (strong) Nin_o *child;

@end
