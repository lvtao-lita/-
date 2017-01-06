//
//  hintBox.m
//  提示框
//
//  Created by lvtao on 17/1/6.
//  Copyright © 2017年 lvtao. All rights reserved.
//

#import "hintBox.h"
@interface hintBox (){
    UIView * showView;
    UILabel * label;
}

@end
@implementation hintBox

+(void)showWith:(NSString *)string{
    CGRect rect = [UIScreen mainScreen].bounds;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView * showView = [[UIView alloc]init];
    showView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:1];
    showView.frame = CGRectMake(80, rect.size.height-100, rect.size.width-160, 50);
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UILabel * label =[[UILabel alloc]init];
    label.text = string;
    label.frame = CGRectMake(0, 0, rect.size.width-160, 50);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [showView addSubview:label];
    [UIView animateWithDuration:1.0 animations:^{
        showView.alpha = 0;
    }completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
}

-(void)showWith:(NSString *)string{
    CGRect rect = [UIScreen mainScreen].bounds;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    showView = [[UIView alloc]init];
    showView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    showView.frame = CGRectMake(1,1, 1, 1);
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    label =[[UILabel alloc]init];
    label.text = string;
    label.frame = CGRectMake(0, 0, rect.size.width-120, 40);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [showView addSubview:label];
    [UIView animateWithDuration:2.0 animations:^{
//        showView.alpha = 0.6;
    }completion:^(BOOL finished) {
        [showView removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
