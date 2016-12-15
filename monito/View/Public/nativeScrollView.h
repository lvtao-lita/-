//
//  nativeScrollView.h
//  monito
//
//  Created by lvtao on 16/11/23.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "affairsTableView.h"
#import "mytableView.h"
@interface nativeScrollView : UIScrollView
@property(nonatomic,strong) mytableView * MtabView;
@property(nonatomic,strong) affairsTableView * AtabView;
-(void)creatSearchView:(NSArray *)arr;
-(void)creatTabViewList:(NSArray * )arr;
-(void)creatTabViewListSource:(NSArray *)sourceAy;
-(void)creatMTabViewListSource:(NSArray *)sourceAy;
@end
