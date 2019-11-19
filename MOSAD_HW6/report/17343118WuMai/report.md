# 中山大学数据科学与计算机学院本科生实验报告
| 课程名称 | 现代操作系统应用开发 |   任课老师   | 郑贵锋 |
| :------: | :------------------: | :----------: | :----: |
|   年级   |          17级         | 专业（方向） |    软件工程    |
|   学号   |      17343118     |     姓名     |     吴劢   |
|   电话   |      15013010440      |    Email     |    460450237@qq.com    |
| 开始日期 |       2019/11/18     |   完成日期   |   2019/11/19     |



## 一、实验题目
多线程和本地存储

## 二、实验内容

1. 只有一个页面，包含一个Label，一个图片列表（可以用UICollectionView或UITableView），以及三个按钮（"加载" "清空" "删除缓存"）。
2. 点击"加载"按钮，若Cache中没有缓存的文件，则加载网络图片并显示在图片列表中，要求：
   - 在子线程下载图片，返回主线程更新UI
   - 图片下载完成前，显示loading图标
   - 图片下载后，存入沙盒的Cache中
3. 点击"加载"按钮，若Cache中已存在图片文件，则直接从Cache中读取出图片并显示。
4. 点击"清空"按钮，清空图片列表中的所有图片。
5. 点击"删除缓存"按钮，删除存储在Cache中的图片文件。

## 三、实验结果

### (1)实验截图

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191119144255693.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191119144426163.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191119144515527.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

### (2)实验步骤以及关键代码
#### ①文件结构
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191119144633924.png)

- ViewController：初始界面的控制器
- MyCell：初始界面中UICollectionViw对应的的自定义cell

#### ②AppDelegate  
> 因为只有一张视图，所以不涉及页面跳转，只需将ViewController作为根控制器即可
```obj-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
```
  
#### ③ViewController
> 五个控件组成，一个UILabel，一个UICollectionView和三个UIButton；UILabel用于实现上方的Picture文本，UICollectionView是中间那块灰色区域，同时用来显示图片，三个UIButton分别实现下方三个按钮；其余的变量都做出了相关注释
```obj-c
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
```

> 加载试图，初始化变量和控件，控件实现都采用懒加载，关于各控件的实现不再赘述，仿照前几次设置好相应属性即可
```obj-c
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
```

> 加载按钮功能的实现，首先判断图片是否在缓存中，如果在则直接加载，如果不在，则先刷新cell加载loading图片，然后再创建子线程去网络请求图片，并在图片下载好后让主线程刷新cell的数据以达到显示图片的效果
```obj-c
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
```

> 清除按钮功能的实现，使用imgType全局变量，再刷新cell，以达到将图片从cell中删除的效果
```obj-c
- (void)cleanPicture: (UIButton *)sender{
    _imgType = 0;
    [self.collectionView reloadData];
}
```

> 删除缓存按钮功能的实现，删除文件，并清空dict内容（内存中的缓存）
```obj-c
- (void)deleteCache: (UIButton *)sender{
    for(NSInteger i = 0; i < _urls.count; i++){
        NSString *filePath = [_cachePath stringByAppendingPathComponent: _urls[i]];
        
        [_fileManager removeItemAtPath:filePath error:nil];
    }
    
    [_dict removeAllObjects];
}
```

> 返回cell内容的DataSource，imgType==0时，即点击后两个按钮时，调用cell中的emptyImage函数；imgType==1时，相当于点击第一个按钮，根据dict中的内容进行判断是否需要显示loading图像，dict最主要的作用是将图片显示到对应位置，而不是打乱顺序显示
```obj-c
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
```

#### ④MyCell
> 定义了三个函数，分别对应加载loading图片，加载网络图片，和将图片从cell中去除;isAdd变量用于判断cell中是否有图片
```obj-c
@interface MyCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *image;
@property (nonatomic) BOOL isAdd;

- (void)setLoading;

- (void)setDownLoadImage: (UIImage *)img;

- (void)emptyImage;

@end
```

> 三个函数的具体实现，都是对image属性简单的变更
```obj-c
//加载loading图
- (void)setLoading{
    self.backgroundColor = [UIColor whiteColor];
    if(_image == nil){
        _image = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"loading.png"]];
        _image.contentMode = UIViewContentModeRedraw;
    }
    else
        _image.image = [UIImage imageNamed: @"loading.png"];
    
    _image.frame = CGRectMake(self.frame.size.width/2 - 30, self.frame.size.height/2 - 30, 60, 60);
    
    _isAdd = YES;
    [self addSubview: _image];
}

//加载网络图片
- (void)setDownLoadImage: (UIImage *)img{
    if(_image == nil){
        _image = [[UIImageView alloc] initWithImage: img];
        _image.contentMode = UIViewContentModeRedraw;
    }
    else
        _image.image = img;
    
    _image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if(_isAdd == NO){
        _isAdd = YES;
        [self addSubview: _image];
    }
}

//去除图片显示
- (void)emptyImage{
    if(_isAdd){
        _isAdd = NO;
        self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:243.0/255.0 blue:247.0/255.0 alpha:1];
        [_image removeFromSuperview];
    }
}
```

### (3)实验遇到的困难以及解决思路
第一个遇到的困难是在多线程上的，因为我是使用循环来生成五个NSBlockOperation对象，而每个NSBlockOperation对象中又会调用CollectionView刷新的功能，但由于该方法只能在主线程中调用，所以要先将其封装成另一个NSBlockOperation对象并加入主线程队列中才能生效。而我一开始是在循环外创建了一个NSBlockOperation对象，而这相当于循环中将其加入主线程五次，所以在运行的时候Xcode会报错，最好是通过在循环内声明定义才得以解决。第二个困难和上次遇到的差不多，也是cell的设置问题，但我对于cell的理解比上次更加深刻，也算是彻底理解了懒加载，所以通过一些逻辑的判断，也是很快解决了问题


## 四、实验思考及感想
  这次试验涉及到了三次课程的内容，上一次的网络请求，以及这次的数据存储和多线程，所幸的是要实现的界面很少，大部分时候都在考虑逻辑上的问题。我一开始使用的是TableView来显示图片，因为此前我一直是使用collectionView来实现涉及到cell的界面，所以我想多使用些其他类型的控件，增加一些经验，但后来发现它的功能无法直接实现结果截图中的效果，要实现还要添加其他控件辅助完成，例如没有缓存图片时显示loading界面，图片范围内的背景色应该变为白色；图片与屏幕两边的间隔；最后让我换成collectionView的原因还是行间距问题，因为TableView的header和footer的delegate设置了并不会生效，经过搜索发现可能是ios系统的原因，有些函数已经失效了，实现的方法还是有的，但是过于复杂，后来作罢只能换成collectionView。
  真的现在一直有种熬过了hw3后，之后的作业都如鱼得水的感觉，也让我逐渐认识到移动端程序设计的魅力。
