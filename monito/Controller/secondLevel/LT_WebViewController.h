//
//  LT_WebViewController.h
//  monito
//
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "operateView.h"
@interface LT_WebViewController : UIViewController
@property (strong,nonatomic) NSArray * BtnAy;
@property (copy,nonatomic)   NSString * URLAy;
@property (strong,nonatomic) UIScrollView * scrollView;
@property (strong,nonatomic) NSDictionary * parameter;
@property (strong,nonatomic) operateView * OPView;
@property (strong,nonatomic) NSString * sign;
@property (assign,nonatomic) int flag;

-(void)creatrightBarButtonItem;
-(void)creatloadItem;
@end
