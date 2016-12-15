//
//  myTableViewCell.h
//  monito
//
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@interface myTableViewCell : UITableViewCell

///@brief 公司名字
@property(strong,nonatomic) UILabel * companyName;

///@brief 中间文字
@property(strong,nonatomic) UILabel * centerLabel;

///@brief 底部文字
@property(strong,nonatomic) UILabel * bottomLabel;

///@brief 日期
@property(strong,nonatomic) UILabel * dateLabel;

@end
