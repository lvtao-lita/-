//
//  operateView.h
//  monito
//
//  Created by lvtao on 16/12/19.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface operateView : UIView

///@brief 流程
@property(strong,nonatomic) UIButton * flowBtn;

///@brief 发送
@property(strong,nonatomic) UIButton * sendBtn;

///@brief 转办
@property(strong,nonatomic) UIButton * transmitBtn;

///@brief 回退
@property(strong,nonatomic) UIButton * rollback;
-(void)creatRollback;
-(void)setButton:(UIButton *)btn WithTittle:(NSString *)tittle AndImage:(NSString *)image;
@end
