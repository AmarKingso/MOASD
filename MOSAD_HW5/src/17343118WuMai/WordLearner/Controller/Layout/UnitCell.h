//
//  UnitCell.h
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef UnitCell_h
#define UnitCell_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UnitCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *title;

- (void)settitle: (NSString *)name;

@end

#endif /* UnitCell_h */
