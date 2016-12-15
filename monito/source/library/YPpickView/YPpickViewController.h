//
//  YPpickViewController.h
//  testUIPickView
//
//  Created by Friend on 16/3/17.
//  Copyright © 2016年 丰吉科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPpickViewModel.h"
//回掉代码块
typedef void (^CalendarBlock)(YPpickViewModel *model);
@interface YPpickViewController : UIViewController
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, copy) CalendarBlock calendarblock;//回调
@property (nonatomic, strong)YPpickViewModel *model ;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com