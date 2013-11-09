//
//  YGFirstViewController.m
//  proPorject
//
//  Created by sunyanguo on 13-10-25.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGFirstViewController.h"

@interface YGFirstViewController ()

@end

@implementation YGFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDate *date = [NSDate date];
    NSLog(@"%ld-%ld-%ld",(long)date.year,(long)date.month,(long)date.day);
    
    for (int i=0 ; i<7; i++) {
//        NSLog(@"weekDay = %@",[date descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]]);
        NSLog(@"%ld-%ld-%ld",(long)date.year,(long)date.month,(long)date.day);
        NSLog(@"weekDay = %@",[[NSDate dateStartOfWeekWithDay:date] descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]]);

        date = [date dateByAddingTimeInterval:-60*60*24*3];
    }

    
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
