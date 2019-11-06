//
//  ChoiceCell.h
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef ChoiceCell_h
#define ChoiceCell_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChoiceCell : UICollectionViewCell

//@property (strong, nonatomic) UIButton *button;
//- (void)setbutton: (NSString *)name;
@property (strong, nonatomic) UILabel *title;
- (void)settitle: (NSString *)name;

@end

#endif /* ChoiceCell_h */
