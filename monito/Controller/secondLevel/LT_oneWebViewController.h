//
//  LT_oneWebViewController.h
//  monito
//
//  Created by lvtao on 16/12/19.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LT_oneWebViewController : UIViewController
///@brief web加载参数
@property(strong,nonatomic) NSDictionary * parameter;

///@brief 其他参数
@property(strong,nonatomic) NSDictionary * WebOtherDic;

///@breif web加载地址
@property(strong,nonatomic) NSString * url;
@end
