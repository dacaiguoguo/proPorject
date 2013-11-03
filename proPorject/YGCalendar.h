//
//  YGCalendar.h
//  proPorject
//
//  Created by sunyanguo on 13-11-2.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YGCalendar : NSObject
@property (nonatomic, strong) UITableView *calandarTableView;
- (void)showInWindow:(UIWindow *)aWindow;
@end

