//
//  timeCalculateNS.m
//  monito
//
//  Created by lvtao on 16/12/16.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "timeCalculateNS.h"

@implementation timeCalculateNS
-(void)timeCalculateWithnewdate:(NSString *)newdate toWithOlddate:(NSString *)olddate{
    NSDateFormatter * dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate * newDate = [dateFomatter dateFromString:newdate];
    NSDate * oldDate = [dateFomatter dateFromString:olddate];
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:oldDate toDate:newDate options:0];
    self.year  = dateCom.year;
    self.month = dateCom.month;
    self.day   = dateCom.day;
    self.hour  = dateCom.hour;
    self.minute= dateCom.minute;
    self.second= dateCom.second;
    
}
@end
