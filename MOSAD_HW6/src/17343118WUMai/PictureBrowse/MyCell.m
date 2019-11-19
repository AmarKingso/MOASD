//
//  TableViewCell.m
//  PictureBrowse
//
//  Created by Amar on 2019/11/17.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCell.h"

@interface MyCell()
@end

@implementation MyCell

//加载loading图
- (void)setLoading{
    self.backgroundColor = [UIColor whiteColor];
    if(_image == nil){
        _image = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"loading.png"]];
        _image.contentMode = UIViewContentModeRedraw;
    }
    else
        _image.image = [UIImage imageNamed: @"loading.png"];
    
    _image.frame = CGRectMake(self.frame.size.width/2 - 30, self.frame.size.height/2 - 30, 60, 60);
    
    _isAdd = YES;
    [self addSubview: _image];
}

//加载网络图片
- (void)setDownLoadImage: (UIImage *)img{
    if(_image == nil){
        _image = [[UIImageView alloc] initWithImage: img];
        _image.contentMode = UIViewContentModeRedraw;
    }
    else
        _image.image = img;
    
    _image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if(_isAdd == NO){
        _isAdd = YES;
        [self addSubview: _image];
    }
}

//去除图片显示
- (void)emptyImage{
    if(_isAdd){
        _isAdd = NO;
        self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:243.0/255.0 blue:247.0/255.0 alpha:1];
        [_image removeFromSuperview];
    }
}

@end
