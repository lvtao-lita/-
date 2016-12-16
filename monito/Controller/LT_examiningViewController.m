//
//  LT_examiningViewController.m
//  monito
//  应急检测
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_examiningViewController.h"
#import "PrefixHeader.pch"
#import "monitoryInquireTableView.h"
@interface LT_examiningViewController (){
    NSArray * sourceAy;
    monitoryInquireTableView * tableView;
    NSMutableDictionary * dic1;
    searchView * search;
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
    tableView = [[monitoryInquireTableView alloc]init];
    tableView.sourceAy = sourceAy;
    tableView.frame = CGRectMakeRelative(0, 65, 375, 538);
    [self.view addSubview:tableView];
}
-(void)RequstWithURL:(NSString *)url{
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"emergency_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@",obj[@"emergency_place"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"emergency_time"]];
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
