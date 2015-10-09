//
//  FourdViewController.m
//  DemoMovistar
//
//  Created by Jorge Gutiérrez on 07-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "FourdViewController.h"

@interface FourdViewController ()

@end

@implementation FourdViewController

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

- (IBAction)send:(id)sender {
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy h:m:s a"];
    NSDate *now=[NSDate date];
    
    NSString *emailTitle =[NSString stringWithFormat:@"Reporte de Juan Perez"];
    // Email Content
    NSString *messageBody =[NSString stringWithFormat:@"Llegada %@ \n Salida %@",[dateFormatter stringFromDate:[user objectForKey:@"init"]],[dateFormatter stringFromDate:now]];
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"soporte@bwg.cl"];
    
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


- (IBAction)call:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+56942403760"]];
}
@end
