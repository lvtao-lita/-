
//
//  LT_oneWebViewController.m
//  monito
//  单个网页加载控制
//  Created by lvtao on 16/12/19.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_oneWebViewController.h"
#import "NetworkRequests.h"
#import "AppDelegate.h"
@interface LT_oneWebViewController (){
    UIWebView * webview;
}

@end

@implementation LT_oneWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webview = [[UIWebView alloc]initWithFrame:CGRectMakeRelative(1, 0, 373, 647)];
    [self.view addSubview:webview];
    [self creatDataSuorce];
    
}
-(void)creatDataSuorce{
    [self requstWithURL:self.url];
}
-(void)requstWithURL:(NSString *)url{
    NSLog(@"%@",self.parameter);
    [NetworkRequests requestWebWithparameters:self.parameter andWithURL:url Success:^(NSString *str) {
        [webview loadHTMLString:str baseURL:nil];
    } failure:^(NSDictionary *dic) {
        
    }];
    
    
}

//创建内联函数 (在程序编译的时候执行,在函数前声明后编译器执行起来更具效率，使宏的定义更节省，不涉及栈的操作)
CG_INLINE CGRect
CGRectMakeRelative(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    //创建appDelegate 在这不会产生类的对象,(不存在引起循环引用的问题)
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    
    //计算返回
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
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
