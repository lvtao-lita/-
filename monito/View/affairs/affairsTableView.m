//
//  affairsTableView.m
//  monito
//  政务信息TabView
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "affairsTableView.h"
#import "dateSource.h"
#import "affairsTableViewCell.h"
#import "PrefixHeader.pch"
@implementation affairsTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.delegate =self;
        self.dataSource = self;
        [self registerClass:[affairsTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceAy.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    affairsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    dateSource * source = self.sourceAy[indexPath.row];
    cell.tittle.text = source.companyName;
    cell.remark.text = source.centerTxet;
    cell.dateTime.text = source.dateText;
    cell.image.image   = [UIImage imageNamed:@"quality.png"];
    //    cell.companyName.text = @"佛山市金刚石工具首饰有限公司";
    //    cell.centerLabel.text = @"委托合同｜委托检测｜电磁辐射｜T20161121013";
    //    cell.bottomLabel.text = @"采样管理｜一般｜管理员";
    //    cell.dateLabel.text   = @"2016-11-11";
    return cell;
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
