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
    NSArray * sourceAy;
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
    NSDictionary * dic = @{@"companyName":@"佛山市金刚石工具首饰有限公司",@"centerTxet":@"委托合同｜委托检测｜电磁辐射｜T20161121013",@"bottomTxet":@"采样管理｜一般｜管理员",@"dateText":@"2016-11-11"};
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 6; i++) {
        [arr addObject:dic];
    }
    sourceAy = [[NSArray alloc]initWithArray:arr];
}

-(void)creatUI{
    UILabel * inquire = [[UILabel alloc]init];
    inquire.frame = CGRectMakeRelative(10, 0, 100, 60);
    inquire.text = @"查询条件";
    
    UITextField * keyword = [[UITextField alloc]init];
    keyword.frame = CGRectMakeRelative(0, 60, 375, 60);
    [self setTextfiled:keyword leftViewname:@"关 键 字："];
    
    UILabel * dateList = [[UILabel alloc]init];
    dateList.frame = CGRectMakeRelative(10, 120, 375, 60);
    dateList.text = @"数据列表";
    
    mytableView * tableView = [[mytableView alloc]init];
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
-(void)inquire{
    NSLog(@"点击查询");
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
