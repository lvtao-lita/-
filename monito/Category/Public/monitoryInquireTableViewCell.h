//
//  monitoryInquireTableViewCell.h
//  monito
//
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface monitoryInquireTableViewCell : UITableViewCell
///@brief cell标题
@property(strong,nonatomic) UILabel * tittle;

///@brief cell备注
@property(strong,nonatomic) UILabel * remark;

///@brief cell时间
@property(strong,nonatomic) UILabel * dateTime;
@end
