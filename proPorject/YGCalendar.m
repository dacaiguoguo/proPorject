//
//  YGCalendar.m
//  proPorject
//
//  Created by sunyanguo on 13-11-2.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGCalendar.h"

@interface YGCalendar()
<UITableViewDataSource,
UITableViewDelegate>

@end

@implementation YGCalendar

- (id)init{
    self = [super init];
    if (self) {
        self.calandarTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.calandarTableView.delegate = self;
        self.calandarTableView.dataSource = self;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 100, 40, 40);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"back" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
        [self.calandarTableView addSubview:button];
    }
    return self;
}

- (void)showInWindow:(UIWindow *)aWindow{
    
    [aWindow addSubview:self.calandarTableView];
}

- (void)removeFromWindow{
    [self.calandarTableView removeFromSuperview];
}
#pragma mark Table View DataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)table {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"header";
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const kReuseIdentifier = @"kReuseIdentifier";
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:kReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kReuseIdentifier] ;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? nil : indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


