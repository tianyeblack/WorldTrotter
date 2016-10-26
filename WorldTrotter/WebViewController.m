//
//  WebViewController.m
//  WorldTrotter
//
//  Created by Ye Tian on 26/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation WebViewController

- (void)loadView {
  _webView = [WKWebView new];
  self.view = _webView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bignerdranch.com"]]];
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

@end
