//
//  Language.m
//  hw2
//
//  Created by Amar on 2019/9/9.
//  Copyright © 2019 Amar. All rights reserved.
//

#import "Language.h"

@implementation Language
- (void)learnOneUnit{
    if(progress_tour == 0)
        progress_tour = 1;
    if(progress_unit == 4){
        progress_tour++;
        progress_unit = 1;
    }
    else
        progress_unit++;
}
- (NSInteger)getTour{
    return progress_tour;
}
- (NSInteger)getUnit{
    return progress_unit;
}

- (bool)isFinish{
    if(progress_tour == 8 && progress_unit == 4)
        return true;
    else
        return false;
}

- (NSString *)getName{
    return @"";
}

@end

@implementation English

- (NSString *)getName{
    return @"英语";
}

@end

@implementation Japanese

- (NSString *)getName{
    return @"日语";
}

@end

@implementation German

- (NSString *)getName{
    return @"德语";
}

@end

@implementation Spanish

- (NSString *)getName{
    return @"西班牙语";
}

@end
