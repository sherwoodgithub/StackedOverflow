//
//  WebOAuthViewController.m
//  Stacked
//
//  Created by Stephen on 2/16/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import "WebOAuthViewController.h"
#import <WebKit/WebKit.h>

@interface WebOAuthViewController () <WKNavigationDelegate>

@end

@implementation WebOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:webView];
  webView.navigationDelegate = self;
  
  NSString *urlString = @"https://stackexchange.com/oauth/dialog?client_id=3197&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success";
  NSURL *url = [NSURL URLWithString:urlString];
  [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  
  NSURLRequest *request = navigationAction.request;
  NSURL *url = request.URL;
  
  if ([url.description containsString:@"access_token"]) {
    
    NSArray *components = [[url description] componentsSeparatedByString:@"="];
    NSString *token = components.lastObject;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
    [userDefaults synchronize];
    
    [self dismissViewControllerAnimated:true completion:nil];
  }
  decisionHandler(WKNavigationActionPolicyAllow);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
