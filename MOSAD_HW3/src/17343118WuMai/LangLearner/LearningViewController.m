//
//  LearningViewController.m
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LearningViewController.h"

@interface  LearningViewController()
@end

@implementation LearningViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _course = [@[@{@"name": @" TOUR1", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR2", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR3", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR4", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR5", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR6", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR7", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]},
                 @{@"name": @" TOUR8", @"list": @[@"Unit1", @"Unit2", @"Unit3", @"Unit4"]}
                ]mutableCopy];
}

#pragma mark - UITableViewDataSource
//返回secttin数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

//返回row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

//返回thHeader的title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _course[section][@"name"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIndex = [NSString stringWithFormat:@"%ld%ldcell", indexPath.section, indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
    }
    NSArray *list = self.course[indexPath.section][@"list"];
    cell.textLabel.text = list[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize: 12];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

#pragma mark - UITableViewDelegate
//f设置row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//设置Header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

//设置view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frameRect = CGRectMake(0, 0, 100, 40);
    UILabel *label = [[UILabel alloc] initWithFrame:frameRect];
    NSString *list = _course[section][@"name"];
    label.text = list;
    label.backgroundColor = [UIColor colorWithRed: 239.0/255.0 green: 239.0/255.0 blue: 244.0/255.0 alpha: 1.0];
    label.font = [UIFont systemFontOfSize: 12];
    label.textColor = [UIColor grayColor];
    return label;
}

@end
