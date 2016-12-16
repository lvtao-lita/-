//
//  monitoryInquireTableView.m
//  monito
//  应急监测，查询tabview
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "monitoryInquireTableView.h"
#import "dateSource.h"
#import "monitoryInquireTableViewCell.h"
#import "PrefixHeader.pch"
@implementation monitoryInquireTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        [self registerClass:[monitoryInquireTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceAy.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    monitoryInquireTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    dateSource * source =self.sourceAy[indexPath.row];
    cell.tittle.text = source.companyName;
    cell.remark.text = source.centerTxet;
    cell.dateTime.text = source.dateText;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 60*app.autoSizeScaleY;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"去选择");
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[self viewController].title isEqualToString:@"应急监测"]) {
        LT_sampleNextViewController * next = [[LT_sampleNextViewController alloc]init];
        next.BtnAy = @[@"信息",@"项目",@"方案",@"附件"];
        next.URLAy = @[@"http://www.baidu.com",@"http://www.sougou.com",@"http://www.hao123.com",@"http://www.souhu.com"];
        [[self viewController].navigationController pushViewController:next animated:YES];
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    [self viewController].navigationItem.backBarButtonItem = backItem;
}
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
