//
//  YGAppDelegate.h
//  LocalNotifation
//
//  Created by sunyanguo on 13-11-6.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UmengKey @"51f8775b56240b8f870e8ec7"
@interface YGAppDelegate : UIResponder <UIApplicationDelegate>
@property UIBackgroundTaskIdentifier bgTask;
@property (strong, nonatomic) UIWindow *window;

@end
