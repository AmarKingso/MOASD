//
//  FinishingViewController.h
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef FinishingViewController_h
#define FinishingViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FinishingViewController : UIViewController
@property (nonatomic, strong) UILabel *fixText;
@property (nonatomic, strong) UILabel *rightNumber;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic) NSInteger count;
@end

#endif /* FinishingViewController_h */
