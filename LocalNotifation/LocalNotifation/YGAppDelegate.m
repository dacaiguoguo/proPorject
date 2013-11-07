//
//  YGAppDelegate.m
//  LocalNotifation
//
//  Created by sunyanguo on 13-11-6.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGAppDelegate.h"
#import "MobClick.h"
@implementation YGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [MobClick startWithAppkey:UmengKey reportPolicy:SEND_INTERVAL   channelId:@"test"];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setLogEnabled:YES];

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)_applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    UIDevice* device = [UIDevice currentDevice];
    
    BOOL backgroundSupported = NO;
    
    if ([device respondsToSelector:@selector(isMultitaskingSupported)])
    {
        backgroundSupported = device.multitaskingSupported;
    }
    if (backgroundSupported && _bgTask==UIBackgroundTaskInvalid)
    {
        UIApplication *app = [UIApplication sharedApplication];
        
        _bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        }];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            while (app.applicationState==UIApplicationStateBackground && _bgTask!=UIBackgroundTaskInvalid  && [app backgroundTimeRemaining] > 10)
            {
                [NSThread sleepForTimeInterval:10];
                NSLog(@"background task %d left left  time %d.", _bgTask, (int)[app backgroundTimeRemaining]);
                
                if ([app backgroundTimeRemaining] < 580)
                {
                    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                    if (localNotif)
                    {
                        localNotif.alertBody = @"测试本地通知消息，后台提示功能。";
                        localNotif.alertAction = NSLocalizedString(@"查看", nil);
                        localNotif.soundName = UILocalNotificationDefaultSoundName;
                        localNotif.applicationIconBadgeNumber = 1;
                        [application presentLocalNotificationNow:localNotif];
                        break;
                    }
                }
            }
            
            NSLog(@"background task %d finished.", _bgTask);
            [app endBackgroundTask:_bgTask];
            _bgTask = UIBackgroundTaskInvalid;
            
        });      
    }
    
}

@end
