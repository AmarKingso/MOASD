//
//  FinishingViewController.m
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinishingViewController.h"

@interface FinishingViewController()
@end

@implementation FinishingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.fixText];
    [self.view addSubview: self.rightNumber];
    [self.view addSubview: self.button];
}

- (UILabel *)fixText{
    if(_fixText == nil){
        _fixText = [[UILabel alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height*0.25, self.view.frame.size.width, 30)];
        [_fixText setText: @"正确数"];
        [_fixText setFont: [UIFont systemFontOfSize: 20]];
        [_fixText setTextColor: [UIColor blackColor]];
        [_fixText setTextAlignment:NSTextAlignmentCenter];
    }
    return _fixText;
}

- (UILabel *)rightNumber{
    if(_rightNumber == nil){
        _rightNumber = [[UILabel alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, 100)];
        [_rightNumber setText: [NSString stringWithFormat: @"%ld", _count]];
        [_rightNumber setFont: [UIFont boldSystemFontOfSize: 48]];
        [_rightNumber setTextColor: [UIColor blackColor]];
        [_rightNumber setTextAlignment:NSTextAlignmentCenter];
    }
    return _rightNumber;
}

- (UIButton *)button{
    if(_button == nil){
        _button = [UIButton buttonWithType: UIButtonTypeSystem];
        _button.frame = CGRectMake(self.view.frame.size.width/8,self.view.frame.size.height*7/8, self.view.frame.size.width*0.75, self.view.frame.size.height/15);
        _button.layer.cornerRadius = 15.0f;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
        [_button setTitle: @"返回" forState: UIControlStateNormal];
        [_button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_button addTarget: self action: @selector(backUnitView:) forControlEvents: UIControlEventTouchDown];
    }
    return _button;
}

#pragma mark - ButtonFunction

- (void)backUnitView: (UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
