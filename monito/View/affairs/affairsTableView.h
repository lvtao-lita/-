//
//  affairsTableView.h
//  monito
//
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface affairsTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSArray * sourceAy;
@end
