//
//  SettingViewController.m
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingViewController.h"
#import "LanguageViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataList = [@[@{@"name": @" ", @"list": @[@"返回语言选择", @"退出登陆"]}]mutableCopy];
    [self.view addSubview: self.tableView];
}

- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  self.view.frame.size.height*3/8+25, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height*5/8-25) style:UITableViewStylePlain];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
        //掩盖多余横线
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataList[section][@"name"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIndex = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
    }
    NSArray *list = self.dataList[indexPath.section][@"list"];
    cell.textLabel.text = list[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize: 14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

@end
