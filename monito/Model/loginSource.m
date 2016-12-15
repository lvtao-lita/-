//
//  loginSource.m
//  monito
//  登录返回数据
//  Created by lvtao on 16/11/30.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "loginSource.h"

@implementation loginSource
+ (id)sharedInstance
{
    static dispatch_once_t once = 0;//保证其block块在应⽤用中只执⾏行⼀一次
    static id _sharedObject = nil;
    dispatch_once(&once, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

@end
