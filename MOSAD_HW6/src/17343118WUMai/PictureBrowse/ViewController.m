//
//  ViewController.m
//  PictureBrowse
//
//  Created by Amar on 2019/11/17.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _urls = [[NSArray alloc] initWithObjects:
            @"d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658",
            @"6215ba6f9b4d53d567795be94a90289c0151ce73400a7-V2tZw8_fw658",
            @"834ccefee93d52a3a2694535d6aadc4bfba110cb55657-mDbhv8_fw658",
            @"f3085171af2a2993a446fe9c2339f6b2b89bc45f4e79d-LacPMl_fw658",
            @"e5c11e316e90656dd3164cb97de6f1840bdcc2671bdc4-vwCOou_fw658"
            , nil];
    
    _imgType = 0;
    _dict = [NSMutableDictionary dictionary];
    _cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    _fileManager = [NSFileManager defaultManager];
    
    [self.view addSubview: self.titleLabel];
    [self.view addSubview: self.collectionView];
    [self.view addSubview: self.load];
    [self.view addSubview: self.empty];
    [self.view addSubview: self.removeCache];
}

- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 9.0 / 80.0)];
        [_titleLabel setText: @"Picture"];
        [_titleLabel setFont: [UIFont systemFontOfSize: 28]];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        //创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        CGRect frame = CGRectMake(0, self.view.frame.size.height * 9.0 / 80.0, self.view.frame.size.width, self.view.frame.size.height * 62.0 / 80.0);
        _collectionView = [[UICollectionView alloc] initWithFrame: frame collectionViewLayout: flowLayout];
        //代理设置
        _collectionView.delegate = (id)self;
        _collectionView.dataSource = (id)self;
        _collectionView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:243.0/255.0 blue:247.0/255.0 alpha:1];
        // 注册cell
        [_collectionView registerClass:[MyCell class] forCellWithReuseIdentifier: @"myCell"];
    }
    return _collectionView;
}

- (UIButton *)load{
    if(_load == nil){
        _load = [UIButton buttonWithType: UIButtonTypeSystem];
        _load.frame = CGRectMake(self.view.frame.size.width/16,self.view.frame.size.height*73/80, self.view.frame.size.width/4, self.view.frame.size.height/20);
        _load.layer.cornerRadius = 10.0f;
        _load.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _load.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
        _load.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
        [_load setTitle: @"加载" forState: UIControlStateNormal];
        [_load setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_load addTarget: self action: @selector(loadPicture:) forControlEvents: UIControlEventTouchDown];
    }
    return _load;
}

- (UIButton *)empty{
    if(_empty == nil){
        _empty = [UIButton buttonWithType: UIButtonTypeSystem];
        _empty.frame = CGRectMake(self.view.frame.size.width*3/8,self.view.frame.size.height*73/80, self.view.frame.size.width/4, self.view.frame.size.height/20);
        _empty.layer.cornerRadius = 10.0f;
        _empty.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _empty.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
        _empty.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
        [_empty setTitle: @"清空" forState: UIControlStateNormal];
        [_empty setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_empty addTarget: self action: @selector(cleanPicture:) forControlEvents: UIControlEventTouchDown];
    }
    return _empty;
}

- (UIButton *)removeCache{
    if(_removeCache == nil){
        _removeCache = [UIButton buttonWithType: UIButtonTypeSystem];
        _removeCache.frame = CGRectMake(self.view.frame.size.width*11/16,self.view.frame.size.height*73/80, self.view.frame.size.width/4, self.view.frame.size.height/20);
        _removeCache.layer.cornerRadius = 10.0f;
        _removeCache.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _removeCache.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
        _removeCache.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
        [_removeCache setTitle: @"删除缓存" forState: UIControlStateNormal];
        [_removeCache setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_removeCache addTarget: self action: @selector(deleteCache:) forControlEvents: UIControlEventTouchDown];
    }
    return _removeCache;
}

#pragma mark - ButtonFunction

- (void)loadPicture: (UIButton *)sender{
    _imgType = 1;
    [self.collectionView reloadData];
    
    NSOperationQueue *mainqueue = [NSOperationQueue mainQueue];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for(NSInteger i = 0; i < _urls.count; i++){
        NSString *filePath = [_cachePath stringByAppendingPathComponent: _urls[i]];
        NSNumber *key = [NSNumber numberWithInteger: i];
        
        //如果沙盒中有缓存，直接读取
        if([_fileManager fileExistsAtPath: filePath]){
            [_dict setObject:[UIImage imageWithContentsOfFile:filePath] forKey:key];
            [self.collectionView reloadData];
        }
        else{       //没有缓存则通过网络下载
            NSBlockOperation *reload = [NSBlockOperation blockOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
            NSBlockOperation *sub = [NSBlockOperation blockOperationWithBlock:^{
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://hbimg.huabanimg.com/%@", self.urls[i]]];
                UIImage *img = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
                
                [self.dict setObject:img forKey:key];
                [mainqueue addOperation: reload];
                
                //x写入缓存
                [UIImagePNGRepresentation(img) writeToFile:filePath atomically:YES];
            }];
            
            [queue addOperation: sub];
        }
    }
}

- (void)cleanPicture: (UIButton *)sender{
    _imgType = 0;
    [self.collectionView reloadData];
}

- (void)deleteCache: (UIButton *)sender{
    for(NSInteger i = 0; i < _urls.count; i++){
        NSString *filePath = [_cachePath stringByAppendingPathComponent: _urls[i]];
        
        [_fileManager removeItemAtPath:filePath error:nil];
    }
    
    [_dict removeAllObjects];
}

#pragma mark - UICollectionViewDelegateFlowLayout

//返回cell尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, self.view.frame.size.height*9/40);
}

//返回cell行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

// 设置上左下右边界缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

#pragma mark - UICollectionViewDataSource

// 返回Section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    //设置cell
    if(_imgType == 0)
        [cell emptyImage];
    else if(_imgType == 1){
        NSNumber *tmp = [NSNumber numberWithInteger: indexPath.item];
        if(_dict[tmp] != nil){
            [cell setDownLoadImage: _dict[tmp]];
        }
        else{
            [cell setLoading];
        }
    }
    
    return  cell;
}

@end
