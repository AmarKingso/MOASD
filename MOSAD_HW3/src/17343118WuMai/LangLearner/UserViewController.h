//
//  UserViewController.h
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef UserViewController_h
#define UserViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "SettingViewController.h"

@interface UserViewController : UIViewController
@property(nonatomic, strong) ProfileViewController* profile;
@property(nonatomic, strong) SettingViewController* setting;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UISegmentedControl *segmented;
@end
#endif /* UserViewController_h */
