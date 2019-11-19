//
//  MyCell.h
//  PictureBrowse
//
//  Created by Amar on 2019/11/17.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef MyCell_h
#define MyCell_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *image;
@property (nonatomic) BOOL isAdd;

- (void)setLoading;

- (void)setDownLoadImage: (UIImage *)img;

- (void)emptyImage;

@end

#endif /* MyCell_h */
