//
//  QuestionViewController.m
//  WordLearner
//
//  Created by Amar on 2019/11/3.
//  Copyright © 2019 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionViewController.h"
#import "FinishingViewController.h"
#import "ChoiceCell.h"

@interface QuestionViewController()
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _questionIndex = 0;
    _selectIndex = -1;
    _count = 0;
    
    //网络请求
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: (id)self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api?unit=%lu", self.currentUnit]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil){
            self.questionDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            [self.view addSubview: self.titleLabel];
            [self.view addSubview: self.collectionView];
            [self.view addSubview: self.answer];
            [self.view addSubview: self.button];
            
            //NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            //NSLog(@"Data = %@",text);
            //NSLog(@"Dict = %@",self.questionDict);
        }
    }];
    
    [dataTask resume];
}

- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height*0.25, self.view.frame.size.width, 30)];
        //NSLog(@"ques=%@",_questionDict[@"data"][_questionIndex][@"question"]);
        [_titleLabel setText: _questionDict[@"data"][_questionIndex][@"question"]];
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
        
        CGRect frame = CGRectMake(self.view.frame.size.width/8, self.view.frame.size.height/3, self.view.frame.size.width*0.75, self.view.frame.size.height/3);
        _collectionView = [[UICollectionView alloc] initWithFrame: frame collectionViewLayout: flowLayout];
        //代理设置
        _collectionView.delegate = (id)self;
        _collectionView.dataSource = (id)self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell
        [_collectionView registerClass:[ChoiceCell class] forCellWithReuseIdentifier: @"ChoiceCell"];
    }
    return _collectionView;
}

- (UIButton *)button{
    if(_button == nil){
        _button = [UIButton buttonWithType: UIButtonTypeSystem];
        _button.frame = CGRectMake(self.view.frame.size.width/8,self.view.frame.size.height*7/8, self.view.frame.size.width*0.75, self.view.frame.size.height/15);
        _button.layer.cornerRadius = 15.0f;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.backgroundColor = [UIColor grayColor];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize: 20];
        _button.userInteractionEnabled = NO;
        _button.tag = 0;
        [_button setTitle: @"确认" forState: UIControlStateNormal];
        [_button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_button addTarget: self action: @selector(triggerAnim:) forControlEvents: UIControlEventTouchDown];
    }
    return _button;
}

- (UIView *)answer{
    if(_answer == nil){
        _answer = [[UIView alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.2)];
        
        //添加左上角label控件
        _answerText = [[UILabel alloc] initWithFrame: CGRectMake(30, 0, _answer.frame.size.width - 60, _answer.frame.size.height/3.0)];
        [_answerText setFont: [UIFont systemFontOfSize: 20]];
        [_answerText setTextColor: [UIColor whiteColor]];
        [_answerText setTextAlignment:NSTextAlignmentLeft];
        
        [self.answer addSubview: self.answerText];
    }
    return _answer;
}

#pragma mark - ButtonFunction

- (void)triggerAnim: (UIButton *)sender{
    //点击确定
    if(sender.tag == 0){
        sender.tag = 1;
        [sender setTitle: @"继续" forState: UIControlStateNormal];
        
        //提交结果
        NSURL *url = [NSURL URLWithString: @"https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api"];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        
        // 设置请求体为JSON
        NSDictionary *dic = @{@"unit": [NSString stringWithFormat:@"%ld", _currentUnit], @"question": [NSString stringWithFormat:@"%ld", _questionIndex], @"answer": _questionDict[@"data"][_questionIndex][@"choices"][_selectIndex]};
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask * dataTask = [self.delegateFreeSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil) {
                //判断结果，并得到答案
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if(dict[@"message"] == [NSString stringWithFormat: @"right"]){
                    sender.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
                    self.answer.backgroundColor = [UIColor colorWithRed:144.0/255.0 green:238.0/255.0 blue:144.0/255.0 alpha:1];
                    self.count++;
                }
                else{
                    sender.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:62.0/255.0 blue:51.0/255.0 alpha:1];
                    self.answer.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:127.0/255.0 blue:128.0/255.0 alpha:1];
                }
                
                [self.answerText setText: [NSString stringWithFormat: @"正确答案：%@", dict[@"data"]]];

                [UIView animateWithDuration: 0.5 animations: ^{
                    self.answer.center = CGPointMake(self.answer.center.x, self.answer.center.y - self.view.frame.size.height*0.2);
                }];
                
                //NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                //NSLog(@"Data = %@",text);
                //NSLog(@"Dict = %@",dict);
            }
        }];
        
        [dataTask resume];
    }
    //点击继续
    else{
        //题目索引+1
        self.questionIndex++;
        
        //题目答完,push结束页面
        if(self.questionIndex == 4){
            FinishingViewController *fvc = [[FinishingViewController alloc] init];
            fvc.count = self.count;
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController: fvc animated: YES];
        }
        else{
            sender.userInteractionEnabled = NO;
            sender.tag = 0;
            sender.backgroundColor = [UIColor grayColor];
            [sender setTitle: @"确认" forState: UIControlStateNormal];
            [UIView animateWithDuration: 0.5 animations: ^{
                self.answer.center = CGPointMake(self.answer.center.x, self.answer.center.y + self.view.frame.size.height*0.2);
            }];
            
            //刷新题目
            self.titleLabel.text = self.questionDict[@"data"][self.questionIndex][@"question"];
            //[self.collectionView reloadData];
            [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

//返回cell尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width*0.75, self.view.frame.size.height/15);
}

//返回cell行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.view.frame.size.height/45;
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
    ChoiceCell *cell = (ChoiceCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ChoiceCell" forIndexPath:indexPath];
    
    //设置cell
    //NSLog(@"choice=%@",_questionDict[@"data"][_questionIndex][@"choices"][indexPath.item]);
    [cell settitle: _questionDict[@"data"][_questionIndex][@"choices"][indexPath.item]];
    
    //设置圆角
    cell.layer.cornerRadius = 15.0f;
    return  cell;
}

// 点击选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //未确认答案前响应点击
    if(self.button.tag == 0){
        _selectIndex = indexPath.item;
        //获取所有cell
        NSArray *arr = [collectionView visibleCells];
        //遍历所有cell，实现同时只激活一个选项
        for(int i = 0; i < 4; i++){
            NSIndexPath *cur = [collectionView indexPathForCell: arr[i]];
            ChoiceCell *cell = (ChoiceCell *)[collectionView cellForItemAtIndexPath: cur];
            if(cur == indexPath){
                cell.title.layer.borderWidth = 1.0f;
                //cell.title.layer.borderColor = [[UIColor greenColor] CGColor];
                cell.title.textColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
            }
            else{
                cell.title.layer.borderWidth = 0;
                cell.title.textColor = [UIColor blackColor];
            }
        }
        _button.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:200.0/255.0 blue:90.0/255.0 alpha:1];
        _button.userInteractionEnabled = YES;
    }
}

@end
