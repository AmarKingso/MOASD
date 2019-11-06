//
//  ChoiceCell.m
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoiceCell.h"

@interface ChoiceCell()
@end

@implementation ChoiceCell

- (void)settitle: (NSString *)name{
    if(_title == nil){
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _title.text = name;
        _title.layer.cornerRadius = 10.0f;
        _title.font = [UIFont boldSystemFontOfSize: 20];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.layer.borderColor = [[UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1] CGColor];
        [self addSubview: _title];
    }
    else{
        _title.text = name;
        _title.layer.borderWidth = 0;
        _title.textColor = [UIColor blackColor];
    }
    
}

@end
