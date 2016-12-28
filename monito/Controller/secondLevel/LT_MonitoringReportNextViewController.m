//
//  LT_MonitoringReportNextViewController.m
//  monito
//  监测报告下页
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_MonitoringReportNextViewController.h"
#import "LT_oneWebViewController.h"
#import "NetworkRequests.h"
@interface LT_MonitoringReportNextViewController ()

@end

@implementation LT_MonitoringReportNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"报告上传" style:UIBarButtonItemStyleDone target:self action:@selector(loadReport:)];
    self.navigationItem.rightBarButtonItem = rightBtn1;
    self.OPView.flowBtn.tag =1;
    self.OPView.sendBtn.tag =2;
    self.OPView.transmitBtn.tag =3;
    [self.OPView setButton:self.OPView.transmitBtn WithTittle:@"回退" AndImage:@"backlog"];
}
-(void)loadReport:(UIBarButtonItem *)btn{
    NSLog(@"loadReport");
}
#pragma mark - 重写点击事件
-(void)clickButton:(UIButton *)btn{
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    if ([btn.titleLabel.text isEqualToString:@"报告"]) {
        [parameter setObject:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [self requstWebWithNumber:0 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskReport/ReportFarm.aspx"];
    }else if ([btn.titleLabel.text isEqualToString:@"监测"]){
        [parameter setObject:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [parameter setObject:self.parameter[@"BusinessId"] forKey:@"business_id"];
        [parameter setObject:self.parameter[@"enviType"] forKey:@"enviType"];
        [self requstWebWithNumber:1 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskReport/ReportManager.aspx"];
    }else if ([btn.titleLabel.text isEqualToString:@"现场"]){
        [parameter setObject:@"Edit" forKey:@"CMD"];
        [parameter setObject:self.parameter[@"EntityName"] forKey:@"EntityName"];
        [parameter setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsID"];
        [parameter setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [parameter setObject:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [parameter setObject:self.parameter[@"TaskSceneId"] forKey:@"TaskSceneId"];
        [parameter setObject:self.parameter[@"UserId"] forKey:@"UserId"];
        [parameter setObject:self.parameter[@"BusinessId"] forKey:@"business_id"];
        [self requstWebWithNumber:2 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/Sample/SampleFarmComm.aspx"];
    }
}
-(void)requstWebWithNumber:(int)num
              andParameter:(NSDictionary *)parameter
                    andURL:(NSString *)url{
    NSArray * webView = [self.scrollView subviews];
    [NetworkRequests requestWebWithparameters:parameter andWithURL:url Success:^(NSString *str) {
        UIWebView * temp = webView[num];
        [temp loadHTMLString:str baseURL:nil];
        
    } failure:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
    }];
}

#pragma mark - 操作点击事件
-(void)operate:(UIButton *)btn{
    NSDictionary * parameterDic = [[NSDictionary alloc]init];
    LT_oneWebViewController * oneWebCon = [[LT_oneWebViewController alloc]init];
    if (btn.tag == 1) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [dic setObject:self.parameter[@"BusinessId"] forKey:@"BusinessId"];
        [dic setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [dic setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        parameterDic = dic;
        oneWebCon.url = @"http://120.24.7.178//fshb/Manager/MobileSvc/WorkFlow/NewVersion/TaskSpanSubmit.aspx";
        NSLog(@"流程");
    }else if (btn.tag ==2){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [dic setObject:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [dic setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [dic setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [dic setObject:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [dic setObject:self.parameter[@"UserId"] forKey:@"UserId"];
        NSLog(@"发送");
        parameterDic = dic;
        oneWebCon.url = @"http://120.24.7.178/fshb/Manager/MobileSvc/WorkFlow/NewVersion/TaskSpanSubmit.aspx";
    }else if (btn.tag ==3){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [dic setObject:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [dic setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [dic setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [dic setObject:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [dic setObject:self.parameter[@"UserId"] forKey:@"UserId"];
        NSLog(@"转办");
        parameterDic = dic;
        oneWebCon.url = @"http://120.24.7.178/fshb/Manager/MobileSvc/WorkFlow/NewVersion/TaskSpanBack.aspx";
    }
    
    oneWebCon.parameter = parameterDic;
    [self.navigationController pushViewController:oneWebCon animated:YES];
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
