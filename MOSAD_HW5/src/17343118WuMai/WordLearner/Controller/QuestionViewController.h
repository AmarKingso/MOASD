//
//  QuestionViewController.h
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef QuestionViewController_h
#define QuestionViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *answer;
@property (nonatomic, strong) UILabel *answerText;

@property (nonatomic, strong) NSURLSession *delegateFreeSession;
@property (nonatomic, strong) NSDictionary *questionDict;
@property (nonatomic) NSUInteger currentUnit;       //当前unit
@property (nonatomic) NSUInteger questionIndex;     //当前问题编号
@property (nonatomic) NSUInteger selectIndex;       //选中选项编号
@property (nonatomic) NSUInteger count;             //正确数量
@end

#endif /* QuestionViewController_h */
