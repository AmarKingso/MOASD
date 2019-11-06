# 中山大学数据科学与计算机学院本科生实验报告
| 课程名称 | 现代操作系统应用开发 |   任课老师   | 郑贵锋 |
| :------: | :------------------: | :----------: | :----: |
|   年级   |          17级         | 专业（方向） |    软件工程    |
|   学号   |      17343118     |     姓名     |     吴劢   |
|   电话   |      15013010440      |    Email     |    460450237@qq.com    |
| 开始日期 |       2019/11/04     |   完成日期   |   2019/11/06     |



## 一、实验题目
网络访问与动画

## 二、实验内容
1. 初始页面是应用启动后显示的第一个页面，包含四个Unit选项（可以用CollectionView实现），要求：
   - 各选项水平居中，且内部的文字也水平居中
   - 每个选项的背景为圆角矩形，且背景色从左上角到右下角渐变（颜色可自选）
   
2. 点击任意Unit后，进入选择题界面。该页面每次显示一道题目，各选项垂直排列且水平居中。

   页面底部是一个UIButton，当没选中任何选项时，该按钮为灰色，不响应点击。

3. 当点击选中任意选项之后，该选项的文字变为绿色，且背景变为绿色的圆角矩形框，底部按钮的背景色也变为绿色。只能同时选中一个选项。

4. 点击底部"确认"按钮后，按钮文字变为"继续"，并且页面底部会弹出一个UIView，弹出动画的持续时间为0.5s。如果选项正确，则弹出的UIView背景色为绿色；若选项不正确，则背景色为红色，同时按钮的颜色也相应地变为红色（UIView的背景色与按钮的背景色需要有区别，建议用RGB值实现）。UIView的左上角显示正确答案。

5. 点击"继续"按钮后，底部UIView向下移动收回，动画持续时间0.5s。然后将页面上显示的题目替换为下一道。

6. 完成所有题目后，点击"继续"，进入分数界面，显示正确题数。

7. 题目信息的获取和选项的判断都需要通过访问网络API实现。该API中的题目共分四个Unit，每个Unit有四道题目，每个题目包含一个中文描述和四个英文单词选项。



需要用到的网络API：

**URL**：`https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api`

#### 根据Unit获取题目：

Type：GET

Example parameters:

```
https://service-p12xr1jd-1257177282.ap-beijing.apigateway.myqcloud.com/release/HW5_api?unit=1
```

Example responses:

```json
{
	"data":[
    {
      "question": "国产的",
      "choices": ["domestic", "majestic", "domesticate", "domesticity"]
    },
    ......
  ]
}
```

#### 判断选项是否正确：

Type：POST

No parameters

Example request body:

```json
{
	"unit": "1",
	"question": "1",
	"answer": "domestic"
}
```

（请求体必须用Json格式）

Example responses:

选择正确：

```json
{
	"message": "right",
	"data": "domestic"
}
```

选择错误：

```json
{
	"message": "wrong",
	"data": "domestic"
}
```

## 三、实验结果

### (1)实验截图
初始界面  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191106164453835.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
  
答题界面  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191106164717356.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191106164853776.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191106165057700.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

结果界面  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191106165156823.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

### (2)实验步骤以及关键代码
#### ①文件结构
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191106165407379.png)

- UnitViewController：初始界面的控制器
- QuestionViewController：答题界面的控制器
- FinishingViewController：结束界面的控制器
- UnitCell：初始界面中单元选项对应的的自定义cell
- ChoiceCell：答题界面选项对应的自定义的cell

#### ②AppDelegate  
> 将navigation作为根视图添加到窗口中，并将初始界面推入
```obj-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    UnitViewController *uvc = [[UnitViewController alloc] init];
    _nav = [[UINavigationController alloc] initWithRootViewController: uvc];
    self.window.rootViewController = _nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
```
  
#### ③UnitViewController
> 由两个控件组成，label用于实现上方文本，collectionview实现四个单元选项
```obj-c
@interface UnitViewController : UIViewController
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
```

> collectionview的响应点击cell事件的代理
```obj-c
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UnitCell *cell = (UnitCell *)[collectionView cellForItemAtIndexPath: indexPath];
    QuestionViewController *qvc = [[QuestionViewController alloc] init];
    qvc.navigationItem.title = cell.title.text;
    qvc.currentUnit = indexPath.item;
    [self.navigationController pushViewController: qvc animated: YES];
}
```

#### ④QuestionViewController
> 两个label分别用于显示题目和答案，一个collectionview实现四个选项，一个button对应下方按钮，一个view用于动画实现
```obj-c
@interface QuestionViewController : UIViewController
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *answer;
@property (nonatomic, strong) UILabel *answerText;

@property (nonatomic, strong) NSURLSession *delegateFreeSession;
@property (nonatomic, strong) NSDictionary *questionDict;
@property (nonatomic) NSUInteger currentUnit;       //当前unit
@property (nonatomic) NSUInteger questionIndex;     //当前问题编号
@property (nonatomic) NSUInteger selectIndex;       //选中选项编号
@property (nonatomic) NSUInteger count;             //正确数量
@end
```

> 将view的加载添加到task中
```obj-c
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
```

> 实现点击一个cell后，当前cell亮起且其他都不亮，同时激活button
```obj-c
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
```

> 实现点击按钮触发不同的事件，通过按钮的tag属性进行判断，tag=0时，按钮为确定按钮，提交选择结果以及触发动画；tag=1时，为继续按钮，如果题目答完则进入结束界面，否则触发动画并进入下一题
```obj-c
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
```

#### ⑤FinishingViewController
> 由两个label，一个button组成，分别实现上方的文本以及结果文本，和底部按钮
```obj-c
@interface FinishingViewController : UIViewController
@property (nonatomic, strong) UILabel *fixText;
@property (nonatomic, strong) UILabel *rightNumber;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic) NSInteger count;
@end
```

> 点击按钮pop界面即可返回初始界面
```obj-c
- (void)backUnitView: (UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
```

### (3)实验遇到的困难以及解决思路
有了hw3打基础，基本上没有遇到什么困难，唯一卡住的地方是刷新题目时reload的问题，不知道为什么只能刷新一次，最后是通过更改cell中初始化的逻辑得以解决


## 四、实验思考及感想
比上次要难一点，但比上上次要好，主要是考察网络请求和动画制作一块，相对页面设计一块涉及的不多，只有三个页面，所以工作量是要比较小的，不过界面之间的联系都比较紧密，涉及到多个界面间参数的传递，所以小地方要注意的很多。总的说下来，有了hw3打基础，现在做这些还是比较简单的，当然这是建立在能够上网查找控件属性的基础上的，并且上一次flutter编程，使我对控件视图等关系的理解加深了，让我确实感受到了自己的进步
