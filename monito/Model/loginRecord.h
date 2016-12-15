//
//  loginRecord.h
//  monito
//  登录名，密码，外网IP，内网IP记录
//  Created by lvtao on 16/11/30.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginRecord : NSObject
@property(copy,nonatomic) NSString * userName;
@property(copy,nonatomic) NSString * password;
@property(copy,nonatomic) NSString * encryptPsw;
@property(copy,nonatomic) NSString * OUTIP;
@property(copy,nonatomic) NSString * INTIP;
@property(assign,nonatomic) BOOL     passflag;
@property(assign,nonatomic) BOOL     OUTIPflag;
@property(assign,nonatomic) BOOL     INPIPflag;

+ (id)sharedInstance;
@end
