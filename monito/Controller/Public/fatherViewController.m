//
//  fatherViewController.m
//  monito
//  样品交接、采样信息,流程查询等父视图
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "fatherViewController.h"
#import "dateSource.h"
#import "timeCalculateNS.h"
#import "LT_sampleNextViewController.h"
#import "LT_oneWebViewController.h"
#import "PrefixHeader.pch"
@interface fatherViewController ()<UITableViewDelegate>{
    NSArray * sourceAy;
    NSMutableDictionary * dic1;
    NSMutableArray * parameterAy;
    NSMutableArray * WebOtherAy;
}

@end

@implementation fatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(inquire)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    [self creatUI];
    [self creatDataSource];
}
-(void)creatDataSource{
    parameterAy = [[NSMutableArray alloc]init];
    WebOtherAy  = [[NSMutableArray alloc]init];
    loginSource * logSource =[loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:self.inqView.endTime.text forKey:@"endtime"];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:logSource.password forKey:@"password"];
    [dic1 setObject:self.inqView.starTime.text forKey:@"starttime"];
    [dic1 setObject:logSource.userName forKey:@"username"];
    if ([self.title isEqualToString:@"采样信息"]) {
        [self requestWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskSampleSvc.asmx/taskSampleList"];
    }
    if ([self.title isEqualToString:@"监测报告"]) {
        [self MonitoringReportRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskReport/TaskReportSvc.asmx/taskReportList"];
    }
    if ([self.title isEqualToString:@"流程查询"]) {
        [self flowInquireRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MonTaskSvc.asmx/taskAllList"];
    }
    if ([self.title isEqualToString:@"档案查询"]) {
        [self flowInquireRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MonTaskSvc.asmx/taskAllList"];
    }
    if([self.title isEqualToString:@"企业档案"]){
        [dic1 setObject:@"2" forKey:@"start"];
        [dic1 setObject:@"10" forKey:@"limit"];
        [dic1 setObject:@"" forKey:@"starttime"];
        [self enterpriseArchivesRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/PollutionUnitSvc.asmx/pollutionUnitList"];
        
    }if ([self.title isEqualToString:@"档案查询"]) {
        [self flowInquireRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MonTaskSvc.asmx/taskAllList"];
    }
    if([self.title isEqualToString:@"设备借还"]){
        
        [self equipmentBorrowAndRepayWith:@"http://120.24.7.178/fshb/Manager/MobileSvc/ApparatusLendingReturnSvc.asmx/lendingReturnList"parameter:dic1];
    }

}
-(void)creatUI{
    UILabel * inquire = [[UILabel alloc]init];
    inquire.frame = CGRectMakeRelative(10, 0, 100, 40);
    inquire.text = @"查询条件";
    
    self.inqView = [[inquireView alloc]init];
    _inqView.frame = CGRectMakeRelative(0, 40, 375, 120);
    
    UILabel * dateList = [[UILabel alloc]init];
    dateList.frame = CGRectMakeRelative(10, 160, 375, 40);
    dateList.text = @"数据列表";
    

    _tableView = [[mytableView alloc]init];
    _tableView.delegate = self;
    _tableView.frame = CGRectMakeRelative(0, 200, 375, 403);
    
    [self.view addSubview:inquire];
    [self.view addSubview:_tableView];
    [self.view addSubview:_inqView];
    [self.view addSubview:dateList];

}



-(void)inquire{
    NSLog(@"点击查询");
    [self.inqView.keyword resignFirstResponder];
    [dic1 setObject:self.inqView.keyword.text forKey:@"keyword"];
    [dic1 setObject:self.inqView.endTime.text forKey:@"endtime"];
    [dic1 setObject:self.inqView.starTime.text forKey:@"starttime"];
    if ([self.title isEqualToString:@"采样信息"]) {
        [self requestWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskSampleSvc.asmx/taskSampleList"];
    }
    if ([self.title isEqualToString:@"监测报告"]) {
        [self MonitoringReportRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskReport/TaskReportSvc.asmx/taskReportList"];
    }
    if ([self.title isEqualToString:@"流程查询"]) {
        [self flowInquireRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MonTaskSvc.asmx/taskAllList"];
    }
    if ([self.title isEqualToString:@"档案查询"]) {
        [self flowInquireRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MonTaskSvc.asmx/taskAllList"];
    }
    if([self.title isEqualToString:@"样品交接"]){
        [self requestWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/TaskSampleSvc.asmx/sampleJoinList"];
    }
    if([self.title isEqualToString:@"企业档案"]){
        [dic1 setObject:@"1" forKey:@"start"];
        [dic1 setObject:@"10" forKey:@"limit"];
        [dic1 setObject:self.inqView.starTime.text forKey:@"starttime"];
        [self enterpriseArchivesRequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/PollutionUnitSvc.asmx/pollutionUnitList"];
        
    }
    if([self.title isEqualToString:@"设备借还"]){
        [self equipmentBorrowAndRepayWith:@"http://120.24.7.178/fshb/Manager/MobileSvc/ApparatusLendingReturnSvc.asmx/lendingReturnList"parameter:dic1];
    }
    
}
//采样信息
-(void)requestWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        [parameterAy removeAllObjects];
        loginSource * logSource = [loginSource sharedInstance];
        for (NSDictionary *obj in dic[@"obj"]) {
            NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
            [parameterDic setObject:logSource.userName forKey:@"username"];
            [parameterDic setObject:logSource.password forKey:@"password"];
            [parameterDic setObject:logSource.obj[@"UserID"] forKey:@"UserId"];
            [parameterDic setObject:logSource.userName forKey:@"UserCode"];
            
            [parameterDic setObject:obj[@"task_id"] forKey:@"sessionid"];
            [parameterDic setObject:obj[@"task_scene_id"] forKey:@"TaskSceneId"];
            [parameterDic setObject:obj[@"link_def_id"] forKey:@"linkdefid"];
            [parameterDic setObject:obj[@"flow_ins_id"] forKey:@"FlowInsId"];
#warning LinkInsId 和 link_ins_id
            [parameterDic setObject:obj[@"link_ins_id"] forKey:@"LinkInsId"];
            [parameterDic setObject:obj[@"link_ins_id"] forKey:@"link_ins_id"];
#warning UserCName 和 UserCode
            [parameterDic setObject:obj[@"started_user_name"] forKey:@"UserCName"];
            [parameterDic setObject:obj[@"business_id"] forKey:@"business_id"];
            
            [parameterDic setObject:obj[@"flow_code"] forKey:@"flowcode"];
            [parameterDic setObject:obj[@"entity_name"] forKey:@"EntityName"];
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"monitor_unit_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@|%@",obj[@"envi_type"],obj[@"monitor_name"],obj[@"entity_name"],obj[@"task_code"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"link_name"],obj[@"link_ins_level"],obj[@"started_user_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"started_time"]];
            [cellAy addObject:data];
            [parameterAy addObject:parameterDic];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];

}
//监测报告
-(void)MonitoringReportRequstWithURL:(NSString *)url{
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        [parameterAy removeAllObjects];
        loginSource * logSource = [loginSource sharedInstance];
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
            [parameterDic setObject:logSource.userName forKey:@"username"];
            [parameterDic setObject:logSource.password forKey:@"password"];
            [parameterDic setObject:logSource.obj[@"UserID"] forKey:@"UserId"];
            [parameterDic setObject:logSource.userName forKey:@"UserCode"];
            
            [parameterDic setObject:obj[@"flow_code"] forKey:@"flowcode"];
            [parameterDic setObject:obj[@"link_def_id"] forKey:@"linkdefid"];
            [parameterDic setObject:obj[@"business_id"] forKey:@"BusinessId"];
            [parameterDic setObject:obj[@"flow_ins_id"] forKey:@"FlowInsId"];
            [parameterDic setObject:obj[@"link_ins_id"] forKey:@"LinkInsId"];
            [parameterDic setObject:obj[@"task_id"] forKey:@"SessionId"];
            [parameterDic setObject:obj[@"started_user_name"] forKey:@"UserCName"];
            [parameterDic setObject:obj[@"envi_type"] forKey:@"enviType"];
            [parameterDic setObject:obj[@"task_scene_id"] forKey:@"TaskSceneId"];
            [parameterDic setObject:obj[@"entity_name"] forKey:@"EntityName"];
            
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"monitor_unit_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@|%@",obj[@"envi_type"],obj[@"monitor_name"],obj[@"entity_name"],obj[@"task_code"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|实验室[%@]|%@",obj[@"link_name"],obj[@"session_state_str"],obj[@"started_user_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"started_time"]];
            [cellAy addObject:data];
            [parameterAy addObject:parameterDic];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}
//流程查询
-(void)flowInquireRequstWithURL:(NSString *)url{
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        [parameterAy removeAllObjects];
        [WebOtherAy removeAllObjects];
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        loginSource * logSource = [loginSource sharedInstance];
        for (NSDictionary *obj in dic[@"obj"]) {
            NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
            NSMutableDictionary * WebDic  = [[NSMutableDictionary alloc]init];
            
            [WebDic setValue:obj[@"business_id"] forKey:@"BusinessId"];
            [WebDic setValue:obj[@"flow_ins_id"] forKey:@"FlowInsId"];
            [WebDic setValue:obj[@"link_ins_id"] forKey:@"LinkInsId"];
            [WebDic setValue:obj[@"task_id"] forKey:@"SessionId"];
            [parameterAy addObject:WebDic];
            
            [WebDic setValue:logSource.userName forKey:@"username"];
            [WebDic setValue:logSource.password forKey:@"password"];
            [WebDic setValue:logSource.idid forKey:@"sessionid"];
            [WebDic setValue:obj[@"report_code"] forKey:@"reportcode"];
            [WebDic setValue:obj[@"report_name"] forKey:@"reportname"];
            [WebOtherAy addObject:WebDic];
            
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"place_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"business_code"],obj[@"envi_type"],obj[@"monitor_type"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"task_code"],obj[@"entity_name"],obj[@"flow_state"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"date_begin"]];
            [cellAy addObject:data];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];

}
//设备借还请求
-(void)equipmentBorrowAndRepayWith:(NSString *)url parameter:(NSDictionary *)parameter{
    //获取当前系统时间
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * nowDateStr = [dateFomatter stringFromDate:nowDate];
    [NetworkRequests requestWithparameters:parameter andWithURL:url Success:^(NSDictionary *dic) {
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@(%@)",obj[@"device_name"],obj[@"equipment_number"]];
            NSArray * strAy = [obj[@"should_also_date"] componentsSeparatedByString:@" "];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|应还日期(%@)",obj[@"leading_personnel"],obj[@"department"],strAy[0]];
            
            if ([obj[@"state"] isEqualToString:@"借出"]) {
                timeCalculateNS * time = [[timeCalculateNS alloc]init];
                [time timeCalculateWithnewdate:nowDateStr toWithOlddate:obj[@"should_also_date"]];
                NSInteger timeD = time.year*365+time.month*30+time.day;
                if (timeD < 0) {
                    data.bottomTxet = [NSString stringWithFormat:@"归还期限（%ld天）",-(long)timeD];
                }else{
                    data.bottomTxet = [NSString stringWithFormat:@"未归还（超时%ld天）",(long)timeD];
                }
            }else if ([obj[@"state"] isEqualToString:@"归还"]){
                data.bottomTxet = [NSString stringWithFormat:@"归还日期（%@）",obj[@"return_date"]];
            }
            NSArray * dateAy = [obj[@"lending_date"] componentsSeparatedByString:@" "];
            data.dateText = [NSString stringWithFormat:@"借出日期(%@)",dateAy[0]];
            
            [cellAy addObject:data];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}
//企业档案列表请求
#warning 参数start（分页），limit未知
-(void)enterpriseArchivesRequstWithURL:(NSString *)url{
    
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"unit_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@",obj[@"unit_industry_type"],obj[@"unit_district_type"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"unit_build_time"]];
            [cellAy addObject:data];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.title isEqual:@"采样信息"]) {
        LT_sampleNextViewController * sampleNextCon = [[LT_sampleNextViewController alloc]init];
        sampleNextCon.BtnAy = @[@"基本",@"现场",@"工况",@"绘图",@"附件",@"操作"];
        sampleNextCon.parameter = parameterAy[indexPath.row];
        [self.navigationController pushViewController:sampleNextCon animated:YES];
    }else if ([self.title isEqual:@"监测报告"]){
        LT_MonitoringReportNextViewController * next = [[LT_MonitoringReportNextViewController alloc]init];
        next.BtnAy = @[@"报告",@"监测",@"现场",@"附件",@"操作"];
        next.parameter = parameterAy[indexPath.row];
        [self.navigationController pushViewController:next animated:YES];
    }else if ([self.title isEqualToString:@"流程查询"]||[self.title isEqualToString:@"档案查询"]){
        LT_oneWebViewController * next = [[LT_oneWebViewController alloc]init];
        next.parameter = parameterAy[indexPath.row];
        next.WebOtherDic = WebOtherAy[indexPath.row];
        next.url = @"http://120.24.7.178/fshb/Manager/MobileSvc/WorkFlow/FlowLogMon.aspx";
        [self.navigationController pushViewController:next animated:NO];
    }else if ([self.title isEqualToString:@"企业档案"]){
        LT_WebViewController * next = [[LT_WebViewController alloc]init];
        next.BtnAy = @[@"信息",@"报告",@"监测",@"附件",@"排口",@"工况"];
//        next.parameter = parameterAy[indexPath.row];
        [self.navigationController pushViewController:next animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 90*app.autoSizeScaleY;
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
