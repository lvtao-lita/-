//
//  LT_queryViewController.m
//  monito
//  其它查询
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_queryViewController.h"
#import "LT_queryNextViewController.h"
#import "PrefixHeader.pch"
@interface LT_queryViewController (){
    NSArray *queryTitleAy;
    NSArray *queryImageAy;
}

@end

@implementation LT_queryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    queryTitleAy = @[@"应急预案",@"质量手册",@"程序文件",@"作业指导书",@"环境标准",@"分析方法"];
    queryImageAy = @[@"",@"",@"",@"",@"",@""];
    [self setBtn];
}

-(void)setBtn{
    for (int i = 0 ; i<queryTitleAy.count; i++) {
        UIButton *btn = [self.btnview.subviews objectAtIndex:i];
        btn.tag = i+1;
        [btn setImage:[UIImage imageNamed:@"quality.png"] forState:UIControlStateNormal];
//        NSLog(@"self.view.subviews-%lu",(unsigned long)self.btnview.subviews.count);
//        [btn setTitle:queryTitleAy[i] forState:UIControlStateNormal];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMakeRelative(0, 80, 120.6, 40)];
        lab.text = queryTitleAy[i];
        lab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:lab];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)click:(UIButton *)btn{
    LT_queryNextViewController * next = [[LT_queryNextViewController alloc]init];
    next.title = queryTitleAy[btn.tag-1];
    [self.navigationController pushViewController:next animated:YES];
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
