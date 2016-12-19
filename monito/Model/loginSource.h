//
//  loginSource.h
//  monito
//  登录返回数据
//  Created by lvtao on 16/11/30.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginSource : NSObject

@property(strong,nonatomic) NSDictionary * obj;

@property(copy,nonatomic)   NSString* idid;

@property(copy,nonatomic) NSString * total;

@property(copy,nonatomic)   NSString * success;

@property(copy,nonatomic) NSString *password;

@property(copy,nonatomic) NSString *userName;


+ (id)sharedInstance;

@end
