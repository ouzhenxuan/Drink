//
//  NSDate+ZXCalendar.m
//  Drink
//
//  Created by ozx on 2019/6/13.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "NSDate+ZXCalendar.h"

@implementation NSDate (ZXCalendar)
+ (NSDate*)getWeekFirstDayDate{
    
    NSDate *date = [NSDate date];
    NSLog(@"datessss %@",date);
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"local %@", localDate);
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:localDate];
    
    // 得到星期几
    // 1(星期天) 2(星期1) 3(星期2) 4(星期3) 5(星期4) 6(星期5) 7(星期6)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 9 - weekDay;
    }
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:localDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    return firstDayOfWeek;
}
@end
