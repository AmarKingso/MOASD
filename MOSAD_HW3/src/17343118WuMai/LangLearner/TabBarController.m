//
//  TarBarController.m
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarController.h"
#import "LearningViewController.h"
#import "UserViewController.h"

@interface TabBarController()
@end

@implementation TabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    //attr为默认设置，selectedAttrs为选中设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10.0];  // 设置文字大小
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];  // 设置文字的前景色
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UITabBarItem *item = [UITabBarItem appearance];  // 设置appearance
    [item setTitleTextAttributes: attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes: selectedAttrs forState:UIControlStateSelected];
    
    //添加子控制器
    LearningViewController *learn = [[LearningViewController alloc] init];
    UserViewController *user = [[UserViewController alloc] init];
    //设置标题
    learn.tabBarItem.title = @"学习";
    user.tabBarItem.title = @"用户";
    //设置默认图片
    learn.tabBarItem.image = [UIImage imageNamed: @"learn1.png"];
    user.tabBarItem.image = [UIImage imageNamed: @"user1.png"];
    //渲染
    learn.tabBarItem.image = [learn.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    user.tabBarItem.image = [user.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中图片
    learn.tabBarItem.selectedImage = [UIImage imageNamed: @"learn2.png"];
    user.tabBarItem.selectedImage = [UIImage imageNamed: @"user2.png"];
    learn.tabBarItem.selectedImage = [learn.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    user.tabBarItem.selectedImage = [user.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置背景颜色
    learn.view.backgroundColor = [UIColor whiteColor];
    user.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController: learn];
    [self addChildViewController: user];
    
    self.delegate = (id)self;
}

#pragma mark - TabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBar
 didSelectViewController:(UIViewController *)viewController{
    if (viewController == [tabBar.viewControllers objectAtIndex: 1])
        [super navigationItem].title = _userTitle;
    else
        [super navigationItem].title = _learnTitle;
    return YES;
}

@end
