//
//  LanguageCell.h
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef LanguageCell_h
#define LanguageCell_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LanguageCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *title;

- (void)setimage: (NSString *)imgpath;
- (void)settitle: (NSString *)name;

@end

#endif /* LanguageCell_h */
