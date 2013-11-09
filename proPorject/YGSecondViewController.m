//
//  YGSecondViewController.m
//  proPorject
//
//  Created by sunyanguo on 13-10-25.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGSecondViewController.h"
#import "YGCalendar.h"

@interface YGSecondViewController ()
@property (strong) YGCalendar *aCalendar;
- (IBAction)showCalendar:(id)sender;

@end

@implementation YGSecondViewController
///
- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)jis{
    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t index) {
        // 执行5次 但顺序未知
        NSLog(@"%zu",index);
    });

}
- (IBAction)showCalendar:(id)sender {
    [self performSelector:@selector(jis) withObject:nil afterDelay:3];
   self.aCalendar  = [[YGCalendar alloc] init];
    [self.aCalendar showInWindow:self.view.window];
}
@end
