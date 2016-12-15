//
//  LT_equipmentViewController.m
//  monito
//  设备借还
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_equipmentViewController.h"
#import "PrefixHeader.pch"
@interface LT_equipmentViewController ()

@end

@implementation LT_equipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * equipmentBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(160, 0, 110, 60)];
    [equipmentBtn setTitle:@"设备借出" forState:UIControlStateNormal];
    [equipmentBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIButton * QRcodeBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(260, 0, 110, 60)];
    [QRcodeBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [QRcodeBtn addTarget:self action:@selector(QRcode:) forControlEvents:UIControlEventTouchUpInside];
    [QRcodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.view addSubview:equipmentBtn];
    [self.view addSubview:QRcodeBtn];
}

-(void)QRcode:(UIButton *)btn{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        SGScanningQRCodeVC *VC = [[SGScanningQRCodeVC alloc] init];
        VC.block = ^(NSString * string){
            self.inqView.keyword.text = string;
        };
        [self.navigationController pushViewController:VC animated:YES];
        
    } else {
        
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
    
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
