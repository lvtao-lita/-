//
//  dateSource.m
//  monito
//  tabview数据模型
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "dateSource.h"

@implementation dateSource
-(dateSource *)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.companyName = dic[@"companyName"];
        self.centerTxet  = dic[@"centerTxet"];
        self.bottomTxet  = dic[@"bottomTxet"];
        self.dateText    = dic[@"dateText"];
    }
    return self;
}
-(dateSource *)initWithdateSource:(dateSource *)obj{
    self = [super init];
    if (self) {
        self.companyName = obj.companyName;
        self.centerTxet  = obj.centerTxet;
        self.bottomTxet  = obj.bottomTxet;
        self.dateText    = obj.dateText;
    }
    return self;
}
@end
