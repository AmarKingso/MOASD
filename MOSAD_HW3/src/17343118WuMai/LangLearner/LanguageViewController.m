//
//  LanguageViewController.m
//  LangLearner
//
//  Created by Amar on 2019/10/6.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageViewController.h"
#import "LanguageCell.h"
#import "TabBarController.h"
#import "AppDelegate.h"

@interface LanguageViewController()
@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.titleLabel];
    [self.view addSubview: self.collectionView];
}

- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height*0.32, self.view.frame.size.width, 30)];
        [_titleLabel setText: @"请选择语言"];
        [_titleLabel setFont: [UIFont systemFontOfSize: 20]];
        [_titleLabel setTextColor: [UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView{
    if(_collectionView == nil){
        //创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        CGRect frame = CGRectMake(self.view.frame.size.width*0.2, self.view.frame.size.height*0.4, self.view.frame.size.width*0.6, self.view.frame.size.height*0.4);
        _collectionView = [[UICollectionView alloc] initWithFrame: frame collectionViewLayout: flowLayout];
        //代理设置
        _collectionView.delegate = (id)self;
        _collectionView.dataSource = (id)self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell
        [_collectionView registerClass:[LanguageCell class] forCellWithReuseIdentifier: @"MyCell"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//返回cell尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 110);
}

//返回cell行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 18;
}

//返回cell列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark - UICollectionViewDataSource

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

// 返回cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    LanguageCell *cell = (LanguageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    //设置cell
    if(indexPath.item == 0){
        [cell setimage: @"English.png"];
        [cell settitle: @"英语"];
    }
    if(indexPath.item == 1){
        [cell settitle:@"德语"];
        [cell setimage:@"German.png"];
    }
    if(indexPath.item == 2){
        [cell settitle:@"日语"];
        [cell setimage:@"Japanese.png"];
    }
    if(indexPath.item == 3){
        [cell settitle:@"西班牙语"];
        [cell setimage:@"Spanish.png"];
    }
    cell.layer.cornerRadius = 5.0;
    return  cell;
}

#pragma mark - UICollectionViewDelegate

// 点击选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LanguageCell *cell = (LanguageCell *)[collectionView cellForItemAtIndexPath: indexPath];
    TabBarController *tabBar=[[TabBarController alloc] init];
    //NSLog(cell.title.text);
    tabBar.learnTitle = [@"学习" stringByAppendingString: cell.title.text];
    tabBar.userTitle = @"个人档案";
    tabBar.navigationItem.title = tabBar.learnTitle;
    [self.navigationController pushViewController:tabBar animated:YES];
}

@end
