//
//  ViewController.m
//  contacto
//
//  Created by Jorge Gutiérrez on 17-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ViewController.h"
#import <linkedin-sdk/LISDK.h>


@interface ViewController ()
@property (nonatomic,strong) NSError *lastError;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *url = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~"];
    
    if ([LISDKSessionManager hasValidSession]) {
        [[LISDKAPIHelper sharedInstance] getRequest:url
                                            success:^(LISDKAPIResponse *response) {
                                                NSLog(@"%@",response.data);
                                            }
                                              error:^(LISDKAPIError *apiError) {
                                                  // do something with error
                                              }];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)conect:(id)sender {
    [LISDKSessionManager createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION,LISDK_CONTACT_INFO_PERMISSION, nil]
                                         state:@"some state"
                        showGoToAppStoreDialog:YES
                                  successBlock:^(NSString *returnState) {
                                      
                                      NSLog(@"%s","success called!");
                                      LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
                                      NSLog(@"value=%@ isvalid=%@",[session value],[session isValid] ? @"YES" : @"NO");
                                      
//                                      NSMutableString *text = [[NSMutableString alloc] initWithString:[session.accessToken description]];
//                                      [text appendString:[NSString stringWithFormat:@",state=\"%@\"",returnState]];
//                                      NSLog(@"Response label text %@",text);
                                      self.lastError = nil;
                                      // retain cycle here?
                                      
                                  }
                                    errorBlock:^(NSError *error) {
                                        NSLog(@"%s %@","error called! ", [error description]);
                                        self.lastError = error;
                                        //  _responseLabel.text = [error description];
                                    }
     ];
}

@end
