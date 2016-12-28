//
//  searchView.m
//  monito
//  原生搜索view及表格
//  Created by lvtao on 16/11/23.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "searchView.h"
#import "PrefixHeader.pch"
@implementation searchView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)creatSearchView:(NSString *)string{
    //搜索View
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMakeRelative(0, 0, 375, 60);
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMakeRelative(10, 10, 300, 40)];
    _searchTextField.placeholder = @"请输入搜索内容";
    _searchTextField.backgroundColor = [UIColor whiteColor];
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(310, 10, 65, 40)];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn setTitle:@"搜索" forState:UIControlStateNormal];
    
    
    [view addSubview:_btn];
    [view addSubview:_searchTextField];
    
    [self addSubview:view];
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
