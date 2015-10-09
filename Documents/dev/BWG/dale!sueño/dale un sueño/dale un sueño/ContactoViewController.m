//
//  ContactoViewController.m
//  dale un sueño
//
//  Created by Jorge Gutiérrez on 13-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ContactoViewController.h"

@interface ContactoViewController ()

@end

@implementation ContactoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+56224805972"]];
}

- (IBAction)showEmail:(id)sender {
// Email Subject
NSString *emailTitle =[NSString stringWithFormat:@"dale! un sueño a %@",[self.childo full_name]];
// Email Content
NSString *messageBody =@"";
// To address
NSArray *toRecipents = [NSArray arrayWithObject:@"contacto@fnh.cl"];

MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
mc.mailComposeDelegate = self;
[mc setSubject:emailTitle];
[mc setMessageBody:messageBody isHTML:NO];
[mc setToRecipients:toRecipents];

// Present mail view controller on screen
[self presentViewController:mc animated:YES completion:NULL];

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
