//
//  UnitViewController.m
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitViewController.h"
#import "UnitCell.h"
#import "QuestionViewController.h"

@interface UnitViewController()
@end

@implementation UnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.titleLabel];
    [self.view addSubview: self.collectionView];
}

- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height*0.2, self.view.frame.size.width, 30)];
        [_titleLabel setText: @"请选择题目"];
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
        
        CGRect frame = CGRectMake(self.view.frame.size.width*0.25, self.view.frame.size.height*0.25, self.view.frame.size.width*0.5, self.view.frame.size.height*0.25);
        _collectionView = [[UICollectionView alloc] initWithFrame: frame collectionViewLayout: flowLayout];
        //代理设置
        _collectionView.delegate = (id)self;
        _collectionView.dataSource = (id)self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell
        [_collectionView registerClass:[UnitCell class] forCellWithReuseIdentifier: @"UnitCell"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//返回cell尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.05);
}

//返回cell行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.height/60;
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
    UnitCell *cell = (UnitCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UnitCell" forIndexPath:indexPath];
    
    //设置cell
    [cell settitle: [NSString stringWithFormat: @"Unit%ld", indexPath.item + 1]];
    
    //设置圆角
    cell.layer.cornerRadius = 10.0f;
    return  cell;
}

#pragma mark - UICollectionViewDelegate

// 点击选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UnitCell *cell = (UnitCell *)[collectionView cellForItemAtIndexPath: indexPath];
    QuestionViewController *qvc = [[QuestionViewController alloc] init];
    qvc.navigationItem.title = cell.title.text;
    qvc.currentUnit = indexPath.item;
    [self.navigationController pushViewController: qvc animated: YES];
}
@end
