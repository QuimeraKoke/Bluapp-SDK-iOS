//
//  FourdViewController.h
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FourdViewController : UIViewController<MFMailComposeViewControllerDelegate>
- (IBAction)send:(id)sender;
- (IBAction)call:(id)sender;


@end
