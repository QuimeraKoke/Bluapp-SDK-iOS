//
//  ContactoViewController.h
//  dale un sueño
//
//  Created by Jorge Gutiérrez on 13-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Niño.h"
#import <MessageUI/MessageUI.h>

@interface ContactoViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (strong) Nin_o *childo;
- (IBAction)call:(id)sender;
- (IBAction)showEmail:(id)sender;

@end
