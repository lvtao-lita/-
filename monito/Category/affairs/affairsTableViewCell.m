//
//  affairsTableViewCell.m
//  monito
//  政务信息tabviewcell自定义
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "affairsTableViewCell.h"
#import "PrefixHeader.pch"
@implementation affairsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.image = [[UIImageView alloc]initWithFrame:CGRectMakeRelative(10, 10, 40, 40)];
        
        self.tittle = [[UILabel alloc]initWithFrame:CGRectMakeRelative(70, 10, 300, 25)];
        
        self.remark = [[UILabel alloc]initWithFrame:CGRectMakeRelative(70, 35, 200, 15)];
        self.remark.textColor = [UIColor grayColor];
        self.remark.font = [UIFont systemFontOfSize:12];
        
        self.dateTime = [[UILabel alloc]initWithFrame:CGRectMakeRelative(265, 35, 110, 15)];
        self.dateTime.textColor = [UIColor grayColor];
        self.dateTime.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.image];
        [self.contentView addSubview:self.tittle];
        [self.contentView addSubview:self.remark];
        [self.contentView addSubview:self.dateTime];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

CG_INLINE CGRect
CGRectMakeRelative(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    //创建appDelegate 在这不会产生类的对象,(不存在引起循环引用的问题)
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    
    //计算返回
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
