//
//  searchView.h
//  monito
//
//  Created by lvtao on 16/11/23.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchView : UIView
@property(strong,nonatomic) UITextField *searchTextField;
@property(strong,nonatomic) UIButton * btn;
-(void)creatSearchView:(NSString *)string;
@end
