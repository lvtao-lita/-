//
//  LT_WebURLViewController.m
//  monito
//
//  Created by lvtao on 17/1/6.
//  Copyright © 2017年 lvtao. All rights reserved.
//

#import "LT_WebURLViewController.h"
#import "SVProgressHUD.h"
#import "PrefixHeader.pch"
@interface LT_WebURLViewController ()<UIWebViewDelegate>

@end

@implementation LT_WebURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    webView.delegate = self;
    NSURL * url = [NSURL URLWithString:self.URL];
    NSURLRequest *  request = [NSURLRequest requestWithURL:url];
    [SVProgressHUD show];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
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
