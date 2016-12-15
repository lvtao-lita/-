//
//  LT_queryParsingViewController.m
//  monito
//  查询分析父视图
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_queryParsingViewController.h"
#import "PrefixHeader.pch"
@interface LT_queryParsingViewController ()

@end

@implementation LT_queryParsingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
}
-(void)creatView{
    self.btnview = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 0, 375, 603)];
    [self.view addSubview:_btnview];
    for (int i = 0; i<5; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(0+j*126, 0+121.6*i, 125, 120.6)];
            
            [btn setImageEdgeInsets:UIEdgeInsetsMake(10, btn.frame.size.width/4, btn.frame.size.height/3, btn.frame.size.width/4)];
            btn.backgroundColor = [UIColor whiteColor];
            [_btnview addSubview:btn];
        }
    }
}



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
