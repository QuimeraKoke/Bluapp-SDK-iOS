//
//  showPushInfo.m
//  bluappsdk
//
//  Created by Manuel Luque on 8/2/15.
//  Copyright (c) 2015 Manuel Luque. All rights reserved.
//

#import "showPushInfo.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+CustomAdditions.h"

@implementation showPushInfo

@synthesize data,manager;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,self.view.frame.size.height)];
    self.myWebView.scalesPageToFit = YES;
    self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(close:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(self.view.frame.size.width-48, 20, 48, 48);
    [self.view addSubview:button];


}

- (void)viewDidAppear:(BOOL)animated {
    [MBProgressHUD fadeInHUDInView:self.view withText:@"Loading"];
    NSString* url = [data objectForKey:@"url"];
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.myWebView loadRequest:request];

}

-(void) close:(UIButton*)sender
{
    NSLog(@"close");
    [manager next];
    [self dismissViewControllerAnimated:FALSE completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
    [MBProgressHUD fadeOutHUDInView:self.view withSuccessText:nil];
}

@end
