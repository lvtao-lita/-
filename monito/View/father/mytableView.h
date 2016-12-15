//
//  mytableView.h
//  monito
//
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface mytableView : UITableView<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSArray * sourceAy;
-(void)loadetableView;
@end
