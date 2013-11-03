//
//  NSDateFormatter+shared.m
//  proPorject
//
//  Created by sunyanguo on 13-11-3.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "NSDateFormatter+shared.h"
@implementation NSDateFormatter (shared)

+ (NSDateFormatter *)sharedFormatter{
    static NSDateFormatter *sharedFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        sharedFormatter.calendar = [NSCalendar currentCalendar];
        sharedFormatter.dateStyle = kCFDateFormatterShortStyle;
        sharedFormatter.timeStyle = kCFDateFormatterShortStyle;
        sharedFormatter.dateFormat = @"yyyy MMMM dd a HH:mm:ss EE";
        sharedFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        
    });
    return sharedFormatter;
}

@end

@implementation NSDate (method)

+ (NSCalendar *)standardCalendar{
    static NSCalendar *gregorian = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        [gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];

    });
    return gregorian;
}

- (NSInteger)day{
    NSDateComponents *components = [[NSDate standardCalendar] components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)month{
    NSDateComponents *components = [[NSDate standardCalendar] components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}
- (NSInteger)year{
    NSDateComponents *components = [[NSDate standardCalendar] components:NSYearCalendarUnit fromDate:self];
    return [components year];
}


-(NSUInteger)firstWeekDayInMonth {
    NSCalendar *gregorian = [NSDate standardCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    [gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];
    
    return [gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
}


+(NSDate *)dateStartOfDay:(NSDate *)date {
    NSDateComponents *components =
    [[NSDate standardCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: date];
    return [[NSDate standardCalendar] dateFromComponents:components];
}

//- (NSString *)descriptionWithLocale:(id)locale{
//    return nil;
//}

@end