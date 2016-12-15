//
//  fatherViewController.m
//  monito
//  样品交接、采样信息,流程查询等父视图
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "fatherViewController.h"
#import "dateSource.h"
#import "PrefixHeader.pch"
@interface fatherViewController (){
    NSArray * sourceAy;
    NSMutableDictionary * dic1;
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
    [self creatDataSource];
    [self creatUI];
}
-(void)creatDataSource{
    loginSource * logSource =[loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"2016-11-28" forKey:@"endtime"];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:logSource.password forKey:@"password"];
    [dic1 setObject:@"2016-08-30" forKey:@"starttime"];
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
    _tableView.frame = CGRectMakeRelative(0, 200, 375, 403);
    
    [self.view addSubview:inquire];
    [self.view addSubview:_tableView];
    [self.view addSubview:_inqView];
    [self.view addSubview:dateList];

}



-(void)inquire{
    NSLog(@"点击查询");
}

-(void)requestWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"monitor_unit_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@|%@",obj[@"envi_type"],obj[@"monitor_name"],obj[@"entity_name"],obj[@"task_code"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"link_name"],obj[@"link_ins_level"],obj[@"started_user_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"started_time"]];
            [cellAy addObject:data];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];

}

-(void)MonitoringReportRequstWithURL:(NSString *)url{
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"monitor_unit_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@|%@",obj[@"envi_type"],obj[@"monitor_name"],obj[@"entity_name"],obj[@"task_code"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|实验室[%@]|%@",obj[@"link_name"],obj[@"session_state_str"],obj[@"started_user_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"started_time"]];
            [cellAy addObject:data];
        }
        sourceAy = [[NSArray alloc]initWithArray:cellAy];
        _tableView.sourceAy = sourceAy;
        [_tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}
-(void)flowInquireRequstWithURL:(NSString *)url{
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
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