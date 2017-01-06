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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 60*app.autoSizeScaleY;
}

@end
