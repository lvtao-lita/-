//
//  loginRecord.m
//  monito
//  登录名，密码，外网IP，内网IP记录
//  Created by lvtao on 16/11/30.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "loginRecord.h"

@implementation loginRecord

+ (id)sharedInstance
{
//    static dispatch_once_t once = 0;//保证其block块在应⽤用中只执⾏行⼀一次
    static loginRecord * sharedObject = nil;
    if (sharedObject == nil) {
        sharedObject = [[loginRecord alloc] init];
    }
//    dispatch_once(&once, ^{
//        sharedObject = [[self alloc] init];
//    });
    return sharedObject;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.userName    = [aDecoder decodeObjectForKey:@"userName"];
        self.password    = [aDecoder decodeObjectForKey:@"password"];
        self.encryptPsw  = [aDecoder decodeObjectForKey:@"encryptPsw"];
        self.OUTIP       = [aDecoder decodeObjectForKey:@"OUTIP"];
        self.INTIP       = [aDecoder decodeObjectForKey:@"INTIP"];
        self.OUTIPflag   = [aDecoder decodeBoolForKey:@"OUTIPflag"];
        self.passflag    = [aDecoder decodeBoolForKey:@"passflag"];
        self.INPIPflag   = [aDecoder decodeBoolForKey:@"INPIPflag"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.encryptPsw forKey:@"encryptPsw"];
    [aCoder encodeObject:self.OUTIP forKey:@"OUTIP"];
    [aCoder encodeObject:self.INTIP forKey:@"INTIP"];
    [aCoder encodeBool:self.passflag forKey:@"passflag"];
    [aCoder encodeBool:self.OUTIPflag forKey:@"OUTIPflag"];
    [aCoder encodeBool:self.INPIPflag forKey:@"INPIPflag"];
    
}

@end
