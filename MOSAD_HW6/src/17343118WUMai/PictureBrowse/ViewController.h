//
//  ViewController.h
//  PictureBrowse
//
//  Created by Amar on 2019/11/17.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *load;
@property (strong, nonatomic) UIButton *empty;
@property (strong, nonatomic) UIButton *removeCache;
@property (strong, nonatomic) NSArray *urls;        //网络图片的url
@property (strong, nonatomic) NSMutableDictionary *dict;        //保存返回得到的data
@property (strong, nonatomic) NSString *cachePath;
@property (strong, nonatomic) NSFileManager *fileManager;
@property (nonatomic) NSInteger imgType;            //一个表示符，0代表隐藏图片，1代表显示图片

@end

