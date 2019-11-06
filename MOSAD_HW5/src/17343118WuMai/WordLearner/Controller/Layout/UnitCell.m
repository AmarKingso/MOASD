//
//  UnitCell.m
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitCell.h"

@interface UnitCell()
@end

@implementation UnitCell

- (void)settitle: (NSString *)name{
    if(_title == nil){
         _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _title.text = name;
        _title.font = [UIFont boldSystemFontOfSize: 20];
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        
        //渐变色
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.cornerRadius = 10.0f;
        //gradientLayer.locations = @[@(0.5),@(1.0)];
        [gradientLayer setColors:@[(id)[[UIColor redColor] CGColor],(id)[[UIColor blueColor] CGColor]]];
        
        //将渐变层添加到cell层中，防止覆盖label
        [self.layer addSublayer: gradientLayer];
    }
    [self addSubview: _title];
}

@end
