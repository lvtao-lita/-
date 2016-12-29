//
//  nativeScrollView.m
//  monito
//  存放原生控件
//  Created by lvtao on 16/11/23.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "nativeScrollView.h"
#import "searchView.h"
#import "affairsTableView.h"
#import "AppDelegate.h"
@implementation nativeScrollView
{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
    }
    return self;
}
-(void)creatSearchView:(NSArray *)arr{
    self.contentSize = CGSizeMake(375*arr.count, 553);
    for (int i = 0; i<arr.count; i++) {
        searchView * sView = [[searchView alloc]init];
        sView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
        [sView creatSearchView:arr[i]];
        [self addSubview:sView];
    }
    
}
//一张表格
-(void)creatTabViewList:(NSArray * )arr{
    for (int i = 0; i < arr.count; i++) {
        //表格
        self.AtabView = [[affairsTableView alloc]init];
        _AtabView.frame = CGRectMakeRelative(0+375*i, 70, 375, 533);
        _AtabView.sourceAy = arr;
        [self addSubview:_AtabView];
    }
}
//多张表格
-(void)creatTabViewListSource:(NSArray *)sourceAy{
    for (int i = 0; i < sourceAy.count; i++) {
        //表格
        self.AtabView = [[affairsTableView alloc]init];
        _AtabView.frame = CGRectMakeRelative(0+375*i, 70, 375, 533);
        _AtabView.sourceAy = sourceAy[i];
        [self addSubview:_AtabView];
        [self.AtabView reloadData];
    }
    
}
//多张表格
-(void)creatMTabViewListSource:(NSArray *)sourceAy{
    for (int i = 0; i < sourceAy.count; i++) {
        //表格
        self.MtabView = [[mytableView alloc]init];
        _MtabView.frame = CGRectMakeRelative(0+375*i, 70, 375, 533);
        _MtabView.sourceAy = sourceAy[i];
        [self addSubview:_MtabView];
        [self.MtabView reloadData];
    }
    
}

-(void)reloadWtihSource:(NSArray *)sourceAy{
    NSArray * view = [self subviews];
    int i = 0;
    for (id tabView in view) {
        if([tabView isKindOfClass:[mytableView class]]){
            if (i<sourceAy.count) {
                mytableView * temp = tabView;
                temp.sourceAy = sourceAy[i];
                i++;
                [tabView reloadData];
            }
        }
    }
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
