//
//  inquireView.h
//  monito
//
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inquireView : UIView<UITextFieldDelegate>
@property(strong,nonatomic) UITextField * starTime;
@property(strong,nonatomic) UITextField * endTime;
@property(strong,nonatomic) UITextField * keyword;
@end
