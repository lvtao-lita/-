//
//  LT_parsingViewController.m
//  monito
//  统计分析
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_parsingViewController.h"
#import "LT_WebURLViewController.h"
#import "PrefixHeader.pch"
@interface LT_parsingViewController (){
    NSArray *queryTitleAy;
    NSArray *queryImageAy;
    NSArray *queryurlAy;
}


@end

@implementation LT_parsingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    queryTitleAy = @[@"废水",@"废气",@"水环境",@"声环境",@"在线监测"];
    queryImageAy = @[@"pie",@"gauge",@"line",@"bar",@"scatter"];
    queryurlAy   = @[@"/Manager/MobileSvc/GIS/Pollution/Pollution.aspx",
                     @"/Manager/MobileSvc/GIS/Pollution/PollutionGas.aspx",
                     @"/Manager/MobileSvc/GIS/Water/Water.aspx",
                     @"/Manager/MobileSvc/GIS/Noise/Noise.aspx",
                     @"/Manager/MobileSvc/GIS/Online/Online.aspx"];
    [self setBtn];
}

-(void)setBtn{
    for (int i = 0 ; i<queryTitleAy.count; i++) {
        UIButton *btn = [self.btnview.subviews objectAtIndex:i];
        btn.tag = i+1;
        [btn setImage:[UIImage imageNamed:queryImageAy[i]] forState:UIControlStateNormal];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMakeRelative(0, 80, 120.6, 40)];
        lab.text = queryTitleAy[i];
        lab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:lab];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)click:(UIButton *)btn{
    LT_WebURLViewController *next = [[LT_WebURLViewController alloc]init];
    loginRecord * logR = [loginRecord sharedInstance];
    NSString * string = [[NSString alloc]init];
    if (![logR.INTIP isEqualToString:@""]) {
        string = [NSString stringWithFormat:@"%@%@",logR.INTIP,queryurlAy[btn.tag-1]];
    }else{
        string = [NSString stringWithFormat:@"%@%@",logR.OUTIP,queryurlAy[btn.tag-1]];
    }
    next.URL = string;
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
