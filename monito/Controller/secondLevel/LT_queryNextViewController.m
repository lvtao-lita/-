//
//  LT_queryNextViewController.m
//  monito
//  其它查询下页
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_queryNextViewController.h"
#import "PrefixHeader.pch"
#import "monitoryInquireTableView.h"

@interface LT_queryNextViewController (){
    monitoryInquireTableView * tableView;
    NSMutableDictionary * dic1;
    NSArray * sourceAy;
}

@end

@implementation LT_queryNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    searchView * search = [[searchView alloc]initWithFrame:CGRectMakeRelative(0, 0, 375, 60)];
    [search creatSearchView:@"输入关键字"];
    [self.view addSubview:search];
    [self creatDataSource];
    [self creatMonitoryInquireTableView];
}
-(void)creatDataSource{
    loginSource * loginS = [loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"" forKey:@"filter"];
    [dic1 setObject:@"10" forKey:@"limit"];
    [dic1 setObject:loginS.password forKey:@"password"];
    [dic1 setObject:loginS.userName forKey:@"username"];
    [dic1 setObject:@"1" forKey:@"start"];
    if ([self.title isEqualToString:@"应急预案"]) {
        [self requestWithURL:@"/Manager/MobileSvc/JobInstructionSvc.asmx/listYA"];
    }
    if ([self.title isEqualToString:@"质量手册"]) {
        [self qualityManualWithURL:@"/Manager/MobileSvc/QualityManualSvc.asmx/list"];
    }
    if ([self.title isEqualToString:@"程序文件"]) {
        [self programFileWithURL:@"/Manager/MobileSvc/ProcedureDocumentSvc.asmx/list"];
    }
    if ([self.title isEqualToString:@"作业指导书"]) {
        [self operationInstructionWithURL:@"/Manager/MobileSvc/JobInstructionSvc.asmx/list"];
    }
    if ([self.title isEqualToString:@"环境标准"]) {
        [self environmentalStandardsWithURL:@"/Manager/MobileSvc/StandardFileSvc.asmx/list"];
    }
    if ([self.title isEqualToString:@"分析方法"]) {
        [self analyticalMethodWithURL:@"/Manager/MobileSvc/MethodFileSvc.asmx/list"];
    }
}

-(void)creatMonitoryInquireTableView{
    tableView = [[monitoryInquireTableView alloc]init];
    tableView.sourceAy = sourceAy;
    tableView.frame = CGRectMakeRelative(0, 65, 375, 538);
    [self.view addSubview:tableView];
}

-(void)requestWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"chapter_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@",obj[@"chapter_name"],obj[@"theme_code"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"execute_date"]];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        tableView.sourceAy = sourceAy;
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
    
}

-(void)qualityManualWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"chapter_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@",obj[@"chapter_name"],obj[@"theme_code"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"execute_date"]];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        tableView.sourceAy = sourceAy;
        [tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}
-(void)programFileWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {

        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@ %@",obj[@"order_num"],obj[@"document_code"]];
            data.centerTxet = [NSString stringWithFormat:@"%@",obj[@"document_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"execute_date"]];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        tableView.sourceAy = sourceAy;
        [tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}

-(void)operationInstructionWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {

        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"document_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"group_name"],obj[@"job_file_type"],obj[@"document_code"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"execute_date"]];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        tableView.sourceAy = sourceAy;
        [tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}

-(void)environmentalStandardsWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {

        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@%@",obj[@"standard_file_name"],obj[@"standard_file_type"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@kB|%@",obj[@"standard_up_date"],obj[@"file_content_len"],obj[@"standard_up_man"]];
            data.dateText = [NSString stringWithFormat:@"%@",@"未下载"];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        tableView.sourceAy = sourceAy;
        [tableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}

-(void)analyticalMethodWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {

        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@%@",obj[@"method_file_name"],obj[@"method_file_type"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@kB|%@",obj[@"method_up_date"],obj[@"file_content_len"],obj[@"method_up_man"]];
            data.dateText = [NSString stringWithFormat:@"%@",@"未下载"];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        tableView.sourceAy = sourceAy;
        [tableView reloadData];
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
