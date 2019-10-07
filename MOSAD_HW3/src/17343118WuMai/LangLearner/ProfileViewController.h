//
//  ProfileViewController.h
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#ifndef ProfileViewController_h
#define ProfileViewController_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataList;
@end

#endif /* ProfileViewController_h */
