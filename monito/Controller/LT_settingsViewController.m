//
//  LT_settingsViewController.m
//  monito
//  系统设置
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_settingsViewController.h"
#import "LT_systemNextViewController.h"
#import "PrefixHeader.pch"
@interface LT_settingsViewController ()

@end

@implementation LT_settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    UIButton *  loadPhoto = [[UIButton alloc]initWithFrame:CGRectMakeRelative(0, 10, 375, 60)];
    loadPhoto.backgroundColor = [UIColor whiteColor];
    [loadPhoto setImageEdgeInsets:UIEdgeInsetsMake(10,self.view.frame.size.width-50, 10, 10)];
    [loadPhoto setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [loadPhoto setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMakeRelative(0, 0, 200, 60)];
    lab.text = @"2G/3G/4G/下加载图片";
    loadPhoto.tag = 10;
    [loadPhoto addSubview:lab];
    [loadPhoto addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadPhoto];
    
    [self creatBtn
     ];
}
-(void)creatBtn{
    NSArray * arr = @[@"清空缓存",@"注销登录",@"关于系统"];
    for (int i =0; i < 3; i++) {
        UIButton *  loadPhoto = [[UIButton alloc]initWithFrame:CGRectMakeRelative(0, 80+i*61, 375, 60)];
        loadPhoto.tag =i+1;
        loadPhoto.backgroundColor = [UIColor whiteColor];
        [loadPhoto setImageEdgeInsets:UIEdgeInsetsMake(10,self.view.frame.size.width-50, 10, 10)];
        [loadPhoto setImage:[UIImage imageNamed:@"arrow-right.png"] forState:UIControlStateNormal];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMakeRelative(0, 0, 200, 60)];
        lab.text = arr[i];
        [loadPhoto addSubview:lab];
        [loadPhoto addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadPhoto];
    }
}

-(void)click:(UIButton *)btn{
    if (btn.tag ==10) {
        if (btn.selected == YES) {
            btn.selected = NO;
        }else{
            btn.selected = YES;
        }
    }else if (btn.tag ==1){
        NSLog(@"清空缓存");
    }else if (btn.tag ==2){
        NSLog(@"注销登录");
    }else if (btn.tag ==3){
        LT_systemNextViewController * next = [[LT_systemNextViewController alloc]initWithNibName:@"system" bundle:nil];
        [self.navigationController pushViewController:next animated:YES];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"";
        self.navigationItem.backBarButtonItem = backItem;
        NSLog(@"关于系统");
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
