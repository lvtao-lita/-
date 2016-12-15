//
//  NSString+subAppend.m
//  monito
//
//  Created by lvtao on 16/11/29.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "NSString+subAppend.h"

@implementation NSString (subAppend)
-(NSString *)substring:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@"obj:" withString:@"\"obj\":"];
    str = [str stringByReplacingOccurrencesOfString:@"],id:" withString:@"],\"id\":"];
    str = [str stringByReplacingOccurrencesOfString:@",total:" withString:@",\"total\":"];
    str = [str stringByReplacingOccurrencesOfString:@",success:" withString:@",\"success\":"];
    str = [str stringByReplacingOccurrencesOfString:@"msg:" withString:@"\"msg\":"];
    str = [str stringByReplacingOccurrencesOfString:@"msg:" withString:@"\"msg\":"];
    str = [str stringByReplacingOccurrencesOfString:@":false" withString:@":\"false\""];
    str = [str stringByReplacingOccurrencesOfString:@":true" withString:@":\"true\""];
    
    return str;
}
@end
