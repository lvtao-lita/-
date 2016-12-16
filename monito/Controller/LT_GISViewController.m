//
//  LT_GISViewController.m
//  monito
//  GIS地图

//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_GISViewController.h"
#import "PrefixHeader.pch"
@interface LT_GISViewController (){
    LT_HomeWeb * HomeWeb;
}


@end

@implementation LT_GISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView * rightview = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 0, 44, 44)];
    UIButton * loadWeb = [[UIButton alloc]init];
    loadWeb.frame =CGRectMakeRelative(0, 0, 44, 44);
    loadWeb.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [loadWeb setImage:[UIImage imageNamed:@"load.png"] forState:UIControlStateNormal];
    [loadWeb addTarget:self action:@selector(loadWeb) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:loadWeb];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    HomeWeb = [[LT_HomeWeb alloc]init];
    HomeWeb.frame = CGRectMakeRelative(0, 0, 375, 603);
    [self.view addSubview:HomeWeb];
    [HomeWeb loadHomeWev:@"http://120.24.7.178/fshb/Manager/MobileSvc/GIS/GisBMap.aspx"];
}
-(void)loadWeb{
    [HomeWeb loadHomeWev:@"http://120.24.7.178/fshb/Manager/MobileSvc/GIS/GisBMap.aspx"];
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
