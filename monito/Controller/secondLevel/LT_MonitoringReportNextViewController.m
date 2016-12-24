//
//  LT_MonitoringReportNextViewController.m
//  monito
//  监测报告下页
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_MonitoringReportNextViewController.h"

@interface LT_MonitoringReportNextViewController ()

@end

@implementation LT_MonitoringReportNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"报告上传" style:UIBarButtonItemStyleDone target:self action:@selector(loadReport:)];
    self.navigationItem.rightBarButtonItem = rightBtn1;
}
-(void)loadReport:(UIBarButtonItem *)btn{
    NSLog(@"loadReport");
}
#pragma mark - 重写点击事件
-(void)clickButton:(UIButton *)btn{
    NSLog(@"!!!!!!!!!!!");
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
