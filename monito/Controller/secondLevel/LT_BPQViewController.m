//
//  LT_BPQViewController.m
//  monito
//  流程查询下页
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_BPQViewController.h"

@interface LT_BPQViewController ()

@end

@implementation LT_BPQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"报告" style:UIBarButtonItemStyleDone target:self action:@selector(report:)];
    UIBarButtonItem * rightBtn2 = [[UIBarButtonItem alloc]initWithTitle:@"附件" style:UIBarButtonItemStyleDone target:self action:@selector(accessory:)];
    NSArray * arr = @[rightBtn2,rightBtn1];
    self.navigationItem.rightBarButtonItems = arr;
}
-(void)report:(UIBarButtonItem *)btn{
    NSLog(@"报告");
}
-(void)accessory:(UIBarButtonItem *)btn{
    NSLog(@"附件");
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
