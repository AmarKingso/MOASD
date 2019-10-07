//
//  LanguageCell.m
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageCell.h"

@interface LanguageCell()
@end

@implementation LanguageCell

- (void)setimage: (NSString *)imgpath{
    if(_image == nil){
        _image = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imgpath]];
        _image.frame = CGRectMake(0, 25, 100,80);
        _image.contentMode = UIViewContentModeScaleAspectFit;
    }
    [self addSubview: _image];
}

- (void)settitle: (NSString *)name{
    if(_title == nil){
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100,20)];
        _title.text = name;
        _title.font = [UIFont systemFontOfSize: 15];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    [self addSubview: _title];
}

@end
