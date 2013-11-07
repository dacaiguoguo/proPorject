//
//  YGViewController.m
//  LocalNotifation
//
//  Created by sunyanguo on 13-11-6.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGViewController.h"

@interface YGViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonClick;
- (IBAction)action:(id)sender;

@end

@implementation YGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
//    UILocalNotification *notification=[[UILocalNotification alloc] init];
//    if (notification!=nil) {
//        NSLog(@">> support local notification");
//        NSDate *now=[NSDate new];
//        notification.fireDate=[now dateByAddingTimeInterval:10];
//        notification.timeZone=[NSTimeZone defaultTimeZone];
//        notification.alertBody=@"该去吃晚饭了！";
//        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
//    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action:(id)sender {
    [self performSelector:@selector(haha) withObject:nil afterDelay:13];

}
@end
