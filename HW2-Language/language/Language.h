//
//  Language.h
//  LanguageLearning
//
//  Created by 陈统盼 on 2019/8/31.
//  Copyright © 2019 TMachine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Language : NSObject {
    NSInteger progress_tour;
    NSInteger progress_unit;
}

- (void)learnOneUnit;
- (NSInteger)getTour;
- (NSInteger)getUnit;
- (bool)isFinish;
- (NSString *)getName;

@end

@interface English : Language {
    
}

- (NSString *)getName;

@end

@interface Japanese : Language {
    
}

- (NSString *)getName;

@end

@interface German : Language {
    
}

- (NSString *)getName;

@end

@interface Spanish : Language {
    
}

- (NSString *)getName;

@end

NS_ASSUME_NONNULL_END
