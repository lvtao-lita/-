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
}

@end

@implementation LT_examiningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    searchView * search = [[searchView alloc]initWithFrame:CGRectMakeRelative(0, 0, 375, 60)];
    [search creatSearchView:@"输入关键字"];
    [self.view addSubview:search];
    [self creatDataSource];
    [self creatMonitoryInquireTableView];
}
-(void)creatDataSource{
    NSDictionary * dic = @{@"companyName":@"佛山市金刚石工具首饰有限公司",@"centerTxet":@"委托合同",@"dateText":@"2016-11-11"};
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 2; i++) {
        [arr addObject:dic];
    }
    sourceAy = [[NSArray alloc]initWithArray:arr];
}
-(void)creatMonitoryInquireTableView{
    monitoryInquireTableView * tableView = [[monitoryInquireTableView alloc]init];
    tableView.sourceAy = sourceAy;
    tableView.frame = CGRectMakeRelative(0, 65, 375, 538);
    [self.view addSubview:tableView];
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
