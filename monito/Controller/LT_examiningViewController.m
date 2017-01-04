//  LT_examiningViewController.m
//  monito
//  应急检测
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.

#import "LT_examiningViewController.h"
#import "PrefixHeader.pch"
#import "monitoryInquireTableView.h"
@interface LT_examiningViewController ()<UITableViewDelegate>{
    NSArray * sourceAy;
    monitoryInquireTableView * TableView;
    NSMutableDictionary * dic1;
    searchView * search;
    NSMutableArray * parameterAy;
}

@end

@implementation LT_examiningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    search = [[searchView alloc]initWithFrame:CGRectMakeRelative(0, 0, 375, 60)];
    [search creatSearchView:@"输入关键字"];
    [search.btn addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:search];
    [self creatDataSource];
    [self creatMonitoryInquireTableView];
}
-(void)creatDataSource{
    parameterAy = [[NSMutableArray alloc]init];
    dic1 = [[NSMutableDictionary alloc]init];
    loginSource * loginS = [loginSource sharedInstance];
    [dic1 setObject:@"" forKey:@"filter"];
    [dic1 setObject:@"10" forKey:@"limit"];
    [dic1 setObject:@"1" forKey:@"start"];
    [dic1 setObject:loginS.password forKey:@"password"];
    [dic1 setObject:loginS.userName forKey:@"username"];

    [self RequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MeetEmergencySvc.asmx/list"];
}

-(void)clik:(UIButton *)btn{
    [dic1 setObject:search.searchTextField.text forKey:@"filter"];
    [dic1 setObject:@"10" forKey:@"limit"];
    [dic1 setObject:@"1" forKey:@"start"];
    NSLog(@"%@", search.searchTextField.text);
    [self RequstWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/MeetEmergencySvc.asmx/list"];
}

-(void)creatMonitoryInquireTableView{
    TableView = [[monitoryInquireTableView alloc]init];
    TableView.sourceAy = sourceAy;
    TableView.delegate = self;
    TableView.frame = CGRectMakeRelative(0, 65, 375, 538);
    [self.view addSubview:TableView];
}
-(void)RequstWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        [parameterAy removeAllObjects];
        loginSource * loginS = [loginSource sharedInstance];
        for (NSDictionary *obj in dic[@"obj"]) {
            NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
            [parameterDic setValue:loginS.password forKey:@"password"];
            [parameterDic setValue:loginS.userName forKey:@"username"];
            [parameterDic setValue:@"Edit" forKey:@"CMD"];
            [parameterDic setValue:obj[@"emergency_id"] forKey:@"EmergencyId"];
            [parameterDic setValue:@"" forKey:@"sessionid"];
            [parameterAy addObject:parameterDic];
            
            
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"emergency_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@",obj[@"emergency_place"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"emergency_time"]];
            [cellAy addObject:data];
        }
        sourceAy = [NSArray arrayWithArray:cellAy];
        TableView.sourceAy = sourceAy;
        [TableView reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 60*app.autoSizeScaleY;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"去选择");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.title isEqualToString:@"应急监测"]) {
        LT_WebViewController * next = [[LT_WebViewController alloc]init];
        next.BtnAy = @[@"信息",@"项目",@"方案",@"附件"];
        next.parameter = parameterAy[indexPath.row];
        next.sign = @"examining";
        [self.navigationController pushViewController:next animated:YES];
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
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

@end
