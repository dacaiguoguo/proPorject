//
//  NSDateFormatter+shared.m
//  proPorject
//
//  Created by sunyanguo on 13-11-3.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "NSDateFormatter+shared.h"

@implementation NSCalendar (standard)

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


@end

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


- (NSInteger)day{
    NSDateComponents *components = [[NSCalendar standardCalendar] components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)month{
    NSDateComponents *components = [[NSCalendar standardCalendar] components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}
- (NSInteger)year{
    NSDateComponents *components = [[NSCalendar standardCalendar] components:NSYearCalendarUnit fromDate:self];
    return [components year];
}


-(NSUInteger)firstWeekDayInMonth {
    NSCalendar *gregorian = [NSCalendar standardCalendar];
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
    [[NSCalendar standardCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: date];
    return [[NSCalendar standardCalendar] dateFromComponents:components];
}



+(NSDate *)dateStartOfWeek {
    return [NSDate dateStartOfWeekWithDay:[NSDate date]];
}

+(NSDate *)dateStartOfWeekWithDay:(NSDate *)aDate {
    NSCalendar *gregorian = [NSCalendar standardCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:aDate];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:aDate options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: beginningOfWeek];
    
    //gestript 剥离
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}


+(NSDate *)dateEndOfWeek {
    NSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                  + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

@end