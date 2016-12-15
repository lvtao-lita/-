//
//  MyCollectionViewCell.m
//  monito
//  首页自定义集合视图
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//
#define With self.frame.size.width
#define Height self.frame.size.height
#import "MyCollectionViewCell.h"
#import "PrefixHeader.pch"

@implementation MyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.Imageiv = [[UIImageView alloc]initWithFrame:CGRectMakeRelative(26,10, 40.5, 51)];
        self.label = [[UILabel alloc] initWithFrame:CGRectMakeRelative(0,61, 92.5, 31.5)];
        self.label.textColor =[UIColor grayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.Imageiv];
        [self.contentView addSubview:self.label];
    }
    return self;
}
CG_INLINE CGRect
CGRectMakeRelative(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    //创建appDelegate 在这不会产生类的对象,(不存在引起循环引用的问题)
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    
    //计算返回
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
}

@end
