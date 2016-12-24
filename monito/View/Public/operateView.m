//
//  operateView.m
//  monito
//  操作流程View 
//  Created by lvtao on 16/12/19.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "operateView.h"
#import "AppDelegate.h"
@implementation operateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1];
        [self creatUIbutton];
    }
    return self;
}
-(void)creatUIbutton{
    
    self.flowBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(0, 0, 375, 60)];
    [self setButton:self.flowBtn WithTittle:@"流程" AndImage:@"flow"];
    
    self.sendBtn =[[UIButton alloc]initWithFrame:CGRectMakeRelative(0, 61, 375, 60)];
    [self setButton:self.sendBtn WithTittle:@"发送" AndImage:@"send"];
    
    self.transmitBtn = [[UIButton alloc]initWithFrame:CGRectMakeRelative(0, 122, 375, 60)];
    [self setButton:self.transmitBtn WithTittle:@"转办" AndImage:@"backlog"];
    
    [self addSubview:self.flowBtn];
    [self addSubview:self.sendBtn];
    [self addSubview:self.transmitBtn];
}

-(void)setButton:(UIButton *)btn WithTittle:(NSString *)tittle AndImage:(NSString *)image{
    [btn setBackgroundColor:[UIColor whiteColor]];
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMakeRelative(5, 5, 50, 50)];
    iv.image =[UIImage imageNamed:image];
    
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMakeRelative(60, 5, 285, 50)];
    label.text = tittle;
    
    UIImageView * iv1 = [[UIImageView alloc]initWithFrame:CGRectMakeRelative(345, 20, 10, 20)];
    iv1.image = [UIImage imageNamed:@"icon_right"];
    
    [btn addSubview:iv];
    [btn addSubview:label];
    [btn addSubview:iv1];
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
