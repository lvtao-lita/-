//
//  LT_ sampleViewController.m
//  monito
//  样品交接
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_ sampleViewController.h"
#import "PrefixHeader.pch"


@interface LT__sampleViewController (){
    NSArray * sourceAy;
}

@end

@implementation LT__sampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskSampleSvc.asmx/sampleJoinList"];
    UIButton * QRcodeBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(260, 0, 110, 40)];
    [QRcodeBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [QRcodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [QRcodeBtn addTarget:self action:@selector(QRcode:) forControlEvents:UIControlEventTouchUpInside];
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
-(void)requestWithURL:(NSString *)url{
    
    loginSource * loginS = [loginSource sharedInstance];
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"2016-11-28" forKey:@"endtime"];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:loginS.password forKey:@"password"];
    [dic1 setObject:@"2016-08-30" forKey:@"starttime"];
    [dic1 setObject:loginS.userName forKey:@"username"];
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"place_name"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@",obj[@"task_code"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"envi_type"],obj[@"monitor_type"],obj[@"entity_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"scene_start_time"]];
            [cellAy addObject:data];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        self.tableView.sourceAy = sourceAy;
        [self.tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
    
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
