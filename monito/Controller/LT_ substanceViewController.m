//
//  LT_ substanceViewController.m
//  monito
//  物质领用
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_ substanceViewController.h"
#import "NetworkRequests.h"
#import "PrefixHeader.pch"
@interface LT__substanceViewController (){
    NSMutableDictionary * dic1;
}

@end

@implementation LT__substanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * equipmentBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(160, 0, 110, 60)];
    [equipmentBtn setTitle:@"领用登记" forState:UIControlStateNormal];
    [equipmentBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIButton * QRcodeBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(260, 0, 110, 60)];
    [QRcodeBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [QRcodeBtn addTarget:self action:@selector(QRcode:) forControlEvents:UIControlEventTouchUpInside];
    [QRcodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self creatDataSource];
    [self.view addSubview:equipmentBtn];
    [self.view addSubview:QRcodeBtn];
}
-(void)creatDataSource{
    loginSource * logSource =[loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:self.inqView.endTime.text forKey:@"endtime"];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:logSource.password forKey:@"password"];
    [dic1 setObject:self.inqView.starTime.text forKey:@"starttime"];
    [dic1 setObject:logSource.userName forKey:@"username"];
    [self requstion];
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
-(void)requstion{
    [NetworkRequests requestWithparameters:dic1 andWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/ReagentSvc.asmx/reagentReceiveList" Success:^(NSDictionary *dic) {
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@(%@)",obj[@"reagent_type_name"],obj[@"reagent_name"]];
            NSArray * strAy = [[NSArray alloc]init];
            if (!([obj[@"valid_date"] isKindOfClass:[NSString class]])) {
                strAy = [NSArray arrayWithObjects:@"nil", nil];
                
            }else{ 
                strAy = [obj[@"valid_date"] componentsSeparatedByString:@" "];
            }
            
            data.centerTxet = [NSString stringWithFormat:@"有效期至(%@)|验收情况(%@)",strAy[0],obj[@"check_result"]];
            
            data.bottomTxet = [NSString stringWithFormat:@"领用人(%@)",obj[@"receive_man"]];
            strAy = [obj[@"receive_date"] componentsSeparatedByString:@" "];
            data.dateText = [NSString stringWithFormat:@"领用日期(%@)",strAy[0]];
            [cellAy addObject:data];
        }
        self.tableView.sourceAy = cellAy;
        [self.tableView reloadData];
        
    } failure:^(NSDictionary *dic) {
        NSLog(@"请求失败");
    }];
}
-(void)inquire{
    NSLog(@"物质领用查询");
    [dic1 setObject:self.inqView.keyword.text forKey:@"keyword"];
    [self requstion];
    
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
