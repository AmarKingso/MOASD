//
//  UserViewController.m
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"
#import "LanguageViewController.h"

@interface  UserViewController()
@end

@implementation UserViewController

- (void) viewDidLoad{
    _profile = [[ProfileViewController alloc] init];
    _profile.view.hidden = false;
    _setting = [[SettingViewController alloc] init];
    _setting.view.hidden = false;
    [self addChildViewController: self.setting];
    [self.view addSubview: self.setting.view];
    [self.view addSubview: self.profile.view];
    [super viewDidLoad];
    [self.view addSubview: self.button];
    [self.view addSubview: self.segmented];
    
}

-(UIButton *)button{
    if(_button == nil){
        _button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        _button.frame = CGRectMake(self.view.frame.size.width*3/8, self.view.frame.size.height*3/16, 110, 110);
        _button.layer.cornerRadius = _button.frame.size.width /2;
        _button.clipsToBounds = YES;
        [_button setTitle: @"Login" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:235.0/255.0 alpha:1.0]];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize: 30.0];
    }
    return _button;
}

-(UISegmentedControl *)segmented{
    if(_segmented == nil){
        NSArray *arr = [[NSArray alloc]initWithObjects:@"用户信息",@"用户设置", nil];
        _segmented = [[UISegmentedControl alloc]initWithItems:arr];
        _segmented.frame = CGRectMake(0, self.view.frame.size.height*3/8, self.view.frame.size.width, 25);
        //主题颜色
        _segmented.tintColor = [UIColor colorWithRed:135.0/255.0 green:206/255.0 blue:235.0/255.0 alpha:1.0];
        //边框宽度和颜色
        _segmented.layer.borderWidth = 1.5;
        _segmented.layer.borderColor = [UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:235.0/255.0 alpha:1.0].CGColor;
        //背景色
        _segmented.backgroundColor = [UIColor whiteColor];
        //未选中字体的颜色
        [_segmented setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor colorWithRed:135.0/255.0 green:206.0/255.0 blue:235.0/255.0 alpha:1.0]} forState:UIControlStateNormal];
        //被选中字体的颜色
        [_segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        //默认选择第0个
        _segmented.selectedSegmentIndex = 0;
        [_segmented addTarget:self action:@selector(indexDidChangeForFrame:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
}

-(void)indexDidChangeForFrame:(UISegmentedControl *)sender{
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            _setting.view.hidden = true;
            _profile.view.hidden = false;
            break;
            
        case 1:
            _setting.view.hidden = false;
            _profile.view.hidden = true;
            break;
        default:
            break;
    }
}

@end
