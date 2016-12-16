//
//  timeCalculateNS.h
//  monito
//
//  Created by lvtao on 16/12/16.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface timeCalculateNS : NSObject
@property(assign,nonatomic) NSInteger year;
@property(assign,nonatomic) NSInteger month;
@property(assign,nonatomic) NSInteger day;
@property(assign,nonatomic) NSInteger hour;
@property(assign,nonatomic) NSInteger minute;
@property(assign,nonatomic) NSInteger second;
-(void)timeCalculateWithnewdate:(NSString *)newdate toWithOlddate:(NSString *)olddate;
@end
