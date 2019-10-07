# 中山大学数据科学与计算机学院本科生实验报告
| 课程名称 | 现代操作系统应用开发 |   任课老师   | 郑贵锋 |
| :------: | :------------------: | :----------: | :----: |
|   年级   |           17级     | 专业（方向） |    软件工程    |
|   学号   |    17343118    |     姓名     |    吴劢    |
|   电话   |  15013010440 |    Email     |    460450237@qq.com    |
| 开始日期 |  2019/09/15  |   完成日期   |     2019/10/07   |

## 一、实验题目
1.   学习使用纯代码进行UI布局
2.   学习UITableView, UICollectionView, UINavigationController, UITabBarController等组件的使用，以及delegate和protocol的概念

## 二、实现内容
1. 初始页面是应用启动后显示的第一个页面，用于选择语种，内容包括：
   - 一个UILabel，要求文字水平居中
   - 一个UICollectionView，包含四个Cells：
     - 每个Cell包含一个UIImageView和一个UILabel，要求用自定义的UICollectionViewCell实现
     - 四个Cell排布成两行，UICollectionView整体需要水平居中
     - 点击任意一个Cell，跳转到语言学习页面
2. 从初始页面跳转后进入到由一个UITabBarController组成的页面，其包含两个子页面"学习XX语"和"个人档案"：
   - 底部的TarBar包含两个按钮"学习"和"用户"，分别对应两个子页面，点击按钮切换到对应的页面
   - 按钮在选中和未选中状态下图片和文字的颜色都不同，参考示例图
3. "语言学习页面"包含一个UITableView：
   - TableView共包含8个Sections（对应八个tours），每个Section包含四个Rows（对应四个units）
   - 每个Section的Header显示"TOUR X"，每个Cell显示"unit X"
   - 顶部导航栏的标题根据首页所选的语言，显示"学习XX语"
4. "个人档案"页面包含一个UIButton，一个UISegmentedControl以及两个子页面：
   - UIButton为圆形，直径110，文字为"Login"，背景色可以自定，要求水平居中
   - UISegmentedControl包含两个items，"用户信息"和"用户设置"，点击切换到相应的子页面，主题色需要与上面的UIButton相同
   - "用户信息"和"用户设置"子页面都包含一个UITableView，均只有一个Section和两个Cells：
     - "用户信息"的TableView包含"用户名"和"邮箱"两个Cells，右侧显示"未登录"
     - "用户设置"的TableView包含"返回语言选择"和"退出登录"两个Cells，要求文字居中，点击"返回语言选择"时，跳回到初始页面

5. 需要用到的图片素材已在`manual/resoures`给出

## 三、实验结果
### (1)实验截图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191007170426365.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191007170458192.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
   ![在这里插入图片描述](https://img-blog.csdnimg.cn/2019100717053589.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191007170614961.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

### (2)实验步骤以及关键代码
#### 实现初始界面
相关文件：
   - LanguageViewController.m
   - LanguageCell.m

**LanguageViewController.m**中创建了一个UILabel和一个UICollectionView，UICollectionView中的cell在LanguageCell.m实现自定义。  
该文件中重写了监测点击的代理，当cell被点击时将下一界面（TabBarController.view）推入UInavigationController中,代码如下：

```obj-c
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
```

**LanguageCell.m**中是对cell进行自定义，为其加入一个UILabel和一个UIImageView

#### 实现TabBarController组成的界面
相关文件：
   - TabBarController.m
   
**TabBarController.m**创建了一个UITabBarController，其通过代理重写进行页面的切换，代码如下：

```obj-c
- (BOOL)tabBarController:(UITabBarController *)tabBar
 didSelectViewController:(UIViewController *)viewController{
    if (viewController == [tabBar.viewControllers objectAtIndex: 1])
        [super navigationItem].title = _userTitle;
    else
        [super navigationItem].title = _learnTitle;
    return YES;
}
```

#### 实现学习界面
相关文件：
   - LearningViewController.m

**LearningViewController.m**创建了一个UITableView，根据题目要求设置好各个参数即可，使用代理来更改view的参数：

```obj-c
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frameRect = CGRectMake(0, 0, 100, 40);
    UILabel *label = [[UILabel alloc] initWithFrame:frameRect];
    NSString *list = _course[section][@"name"];
    label.text = list;
    label.backgroundColor = [UIColor colorWithRed: 239.0/255.0 green: 239.0/255.0 blue: 244.0/255.0 alpha: 1.0];
    label.font = [UIFont systemFontOfSize: 12];
    label.textColor = [UIColor grayColor];
    return label;
}
```

#### 实现用户界面
相关文件：
   - UserViewController.m
   - ProfileViewController.m
   - SettingViewController.m

**UserViewController.m**创建了一个UIButton,一个UISegmentedController和两个UITableView。  
SegmentedController通过自定义函数来实现点击不同segment时切换到不同界面，代码如下：

```obj-c
-(void)indexDidChangeForFrame:(UISegmentedControl *)sender{
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            _setting.view.hidden = true;
            _profile.view.hidden = false;
            break;
            
        case 1:
            _setting.view.hidden = false;
            _profile.view.hidden = true;
            break;
        default:
            break;
    }
}
```
代码中的两个变量分别指向两个UITableView，分别在**ProfileViewController.m**和**SettingViewController.m**中实现，两者大同小异


### (3)实验遇到的困难以及解决思路
基本上遇到的全是困难，对于各种控件的属性不熟悉，只能一个个控件上网去查找属性和代理，然后判断那些是自己需要的。  
还有关于各种参数的选取，例如自动布局所需要控件的动态大小和位置，以及颜色rgb'的选取。以前上web2.0都有用到相应的测量尺寸和颜色的工具，所以可以直接拿来用。  
还有就是一开始根据文件中给的项目结构来写，涉及的文件有点多，一时没有缕清各个控件之间的关系，最后还是靠同学的指点才弄清楚了。

## 四、实验思考及感想
做完这次试验，真心觉得通过代码来进行布局太痛苦了，要考虑很多因素，各组件之间的位置关系，层级关系，还有大小的设定等等，没有一个直观的感受，只能每次写完跑一遍，特别是在虚拟机上跑，有时还会卡顿，给人的感觉就是更加费时费力的web2.0 。还有UI控件各种奇奇怪怪的属性和参数，要一个个去网上查找，只能说对于老手来说做起来感觉方便，对于新手来说就是一场噩梦。
