//
//  NSDateFormatter+shared.h
//  proPorject
//
//  Created by sunyanguo on 13-11-3.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (shared)
+ (NSDateFormatter *)sharedFormatter;

@end

@interface NSDate (method)
- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;
/* 取得 self 本月的1日是周几 */
-(NSUInteger)firstWeekDayInMonth;
+(NSDate *)dateStartOfDay:(NSDate *)date ;
@end