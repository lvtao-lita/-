//
//  LT_WebViewController.h
//  monito
//
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LT_WebViewController : UIViewController
@property (strong,nonatomic) NSArray * BtnAy;
@property (copy,nonatomic) NSString * URLAy;

-(void)creatrightBarButtonItem;
-(void)creatloadItem;
@end
