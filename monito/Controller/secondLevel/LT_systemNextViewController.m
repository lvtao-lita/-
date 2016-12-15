//
//  LT_systemNextViewController.m
//  monito
//  关于系统
//  Created by lvtao on 16/11/25.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_systemNextViewController.h"
#import "LT_feedbackFunctionViewController.h"

@interface LT_systemNextViewController ()

@end

@implementation LT_systemNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于系统";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)FunctionJump:(UIButton *)sender {
    LT_feedbackFunctionViewController * next = [[LT_feedbackFunctionViewController alloc]init];
    next.title = @"功能介绍";
    [self.navigationController pushViewController:next animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}
- (IBAction)feedbackJump:(UIButton *)sender {
    LT_feedbackFunctionViewController * next = [[LT_feedbackFunctionViewController alloc]init];
    next.title = @"意见反馈";
    [self.navigationController pushViewController:next animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
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
