//
//  navBottomBtnView.m
//  monito
//  导航栏下btnView
//  Created by lvtao on 16/11/23.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "navBottomBtnView.h"
#import "PrefixHeader.pch"
@implementation navBottomBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)creatButton:(NSArray *)BtnAy{
    for (int i = 0; i<BtnAy.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:BtnAy[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [self addSubview:btn];
        if (BtnAy.count<5) {
            btn.frame = CGRectMakeRelative(0+375.0/BtnAy.count*i, 0, 375.0/BtnAy.count, 60 );
            
        }else{
            btn.frame = CGRectMakeRelative(0+75*i, 0, 75, 60);
            
        }
        if (i==0) {
            btn.selected = YES;
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
