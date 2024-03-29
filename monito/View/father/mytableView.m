//
//  mytableView.m
//  monito
//  父视图 tabView
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "mytableView.h"
#import "dateSource.h"
#import "LT_WebViewController.h"
#import "PrefixHeader.pch"
@implementation mytableView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        [self registerClass:[myTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}
-(void)loadetableView{
    [self reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceAy.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    dateSource * source = self.sourceAy[indexPath.row];
    cell.companyName.text = source.companyName;
    cell.centerLabel.text = source.centerTxet;
    cell.bottomLabel.text = source.bottomTxet;
    cell.dateLabel.text   = source.dateText;
    if ([source.bottomTxet rangeOfString:@"超时"].location != NSNotFound) {
        cell.bottomLabel.textColor = [UIColor redColor];
    }
//    cell.companyName.text = @"佛山市金刚石工具首饰有限公司";
//    cell.centerLabel.text = @"委托合同｜委托检测｜电磁辐射｜T20161121013";
//    cell.bottomLabel.text = @"采样管理｜一般｜管理员";
//    cell.dateLabel.text   = @"2016-11-11";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 90*app.autoSizeScaleY;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"已经选中cell时调用");
    //在跳转之前，将该cell去选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[self viewController].title  isEqual:@"物质领用"]){
        LT_WebViewController *next = [[LT_WebViewController alloc]init];
        [next creatrightBarButtonItem];
        [[self viewController].navigationController pushViewController:next animated:YES];
    }else{
        LT_WebViewController *next = [[LT_WebViewController alloc]init];
        [[self viewController].navigationController pushViewController:next animated:YES];
    }
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    [self viewController].navigationItem.backBarButtonItem = backItem;
    //选中某一个cell时，做页面跳转
}
//获取父视图
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
