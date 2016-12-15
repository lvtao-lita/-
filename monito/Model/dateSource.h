//
//  dateSource.h
//  monito
//
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dateSource : NSObject
@property(copy,nonatomic) NSString * companyName;
@property(copy,nonatomic) NSString * centerTxet;
@property(copy,nonatomic) NSString * bottomTxet;
@property(copy,nonatomic) NSString * dateText;

-(dateSource *)initWithDic:(NSDictionary *)dic;

-(dateSource *)initWithdateSource:(dateSource *)obj;
@end
