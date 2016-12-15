//
//  myTableViewCell.m
//  monito
//
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "myTableViewCell.h"

@implementation myTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.companyName = [[UILabel alloc]init];
        self.companyName.frame = CGRectMakeRelative(0, 0, 375, 30);
        self.companyName.font = [UIFont boldSystemFontOfSize:18];
        self.centerLabel = [[UILabel alloc]init];
        self.centerLabel.frame = CGRectMakeRelative(0, 30, 375, 30);
        self.centerLabel.font = [UIFont systemFontOfSize:12];
        self.centerLabel.tintColor = [UIColor grayColor];
        self.bottomLabel = [[UILabel alloc]init];
        self.bottomLabel.frame = CGRectMakeRelative(0, 60, 180, 30);
        self.bottomLabel.font = [UIFont systemFontOfSize:12];
        self.bottomLabel.tintColor = [UIColor grayColor];
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.frame = CGRectMakeRelative(265, 60, 110, 30);
        self.dateLabel.tintColor = [UIColor grayColor];
        [self.contentView addSubview:self.companyName];
        [self.contentView addSubview:self.centerLabel];
        [self.contentView addSubview:self.bottomLabel];
        [self.contentView addSubview:self.dateLabel];
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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
