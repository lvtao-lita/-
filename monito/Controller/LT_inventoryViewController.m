//
//  LT_inventoryViewController.m
//  monito
//  物质库存
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_inventoryViewController.h"
#import "PrefixHeader.pch"
@interface LT_inventoryViewController (){
    NSMutableArray * sourceAy;
    UITextField * keyword;
    mytableView * tableView;
    NSMutableDictionary * dic1;
}

@end

@implementation LT_inventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStyleDone target:self action:@selector(inquire)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    [self creatDataSource];
    [self creatUI];
}
-(void)creatDataSource{
    loginSource * logSource =[loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:@"10" forKey:@"limit"];
    [dic1 setObject:@"1" forKey:@"start"];
    [dic1 setObject:logSource.password forKey:@"password"];
    [dic1 setObject:logSource.userName forKey:@"username"];
    [self requstion];
}

-(void)creatUI{
    UILabel * inquire = [[UILabel alloc]init];
    inquire.frame = CGRectMakeRelative(10, 0, 100, 60);
    inquire.text = @"查询条件";
    
    keyword = [[UITextField alloc]init];
    keyword.frame = CGRectMakeRelative(0, 60, 375, 60);
    [self setTextfiled:keyword leftViewname:@"关 键 字："];
    
    UILabel * dateList = [[UILabel alloc]init];
    dateList.frame = CGRectMakeRelative(10, 120, 375, 60);
    dateList.text = @"数据列表";
    
    tableView = [[mytableView alloc]init];
    tableView.sourceAy = sourceAy;
    tableView.frame = CGRectMakeRelative(0, 180, 375, 427);
    
    [self.view addSubview:inquire];
    [self.view addSubview:tableView];
    [self.view addSubview:dateList];
    
}
-(void)setTextfiled:(UITextField *)tf leftViewname:(NSString *)string{
    
    tf.borderStyle = UITextBorderStyleRoundedRect;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMakeRelative(10, 0, 120, 60)];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMakeRelative(10, 0, 120, 60)];
    lab.text = string;
    [view addSubview:lab];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = view;
    [self.view addSubview:tf];
}
#warning 未达安全库存量判断条件未知
-(void)requstion{
    NSDictionary *parameter = [NSDictionary dictionaryWithDictionary:dic1];
    [NetworkRequests requestWithparameters:parameter andWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/ReagentSvc.asmx/reagentList" Success:^(NSDictionary *dic) {
        NSMutableArray * cellAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@(%@)",obj[@"reagent_type_name"],obj[@"reagent_name"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@",obj[@"gb_code"],obj[@"toxicity_level_name"]];
            data.bottomTxet = [NSString stringWithFormat:@"库存量 %@",obj[@"inventory_count"]];
            data.dateText = [NSString stringWithFormat:@"未达安全存量"];
            [cellAy addObject:data];
        }
        tableView.sourceAy = cellAy;
        [tableView reloadData];
        
    } failure:^(NSDictionary *dic) {
        NSLog(@"请求失败%@",dic[@"msg"]);
    }];
}
-(void)inquire{
    loginSource * logSource =[loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:keyword.text forKey:@"keyword"];
    [dic1 setObject:logSource.password forKey:@"password"];
    [dic1 setObject:logSource.userName forKey:@"username"];
    [self requstion];
    NSLog(@"物质库存查询");
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
