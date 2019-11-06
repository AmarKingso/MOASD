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

### (2)实验步骤以及关键代码
#### ①搭建Flutter开发环境
根据官方教程进行搭建，并下载安装与配置Android Studio，这里给出Android Studio国内[下载网址](https://developer.android.google.cn/studio/)  
需要注意的是Android Studio要求JDK版本在8或以下，否则license无法更新

#### ②正式开始编写代码
- **文件结构如下**  
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191024000637740.png)  

- **main.dart**  
> 作为App的入口，对主题颜色进行了设置，HomePage在feed_home中实现
```dart
import 'package:flutter/material.dart';
import 'package:flutter_app/feed_home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW4',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}
```
  
- **feed_home.dart**  
_HomePageState类中实现的函数分别为：
  - 在Flutter层获取电池电量的API  
  ```dart
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = '100%';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result%';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  ```
  
  - APP的初始页面（AppBar，BottomAppBar）
  ```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helo'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
          padding: EdgeInsets.only(left: 12.0),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.battery_unknown),
            padding: EdgeInsets.only(right: 12.0),
            onPressed: _getBatteryLevel,
            label: Text(_batteryLevel,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: _homeBody(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              disabledColor: Colors.black,
            ),
            IconButton(icon: Icon(Icons.search)),
            IconButton(icon: Icon(Icons.add_box)),
            IconButton(icon: Icon(Icons.favorite)),
            IconButton(icon: Icon(Icons.account_box)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,     //均匀分布
        ),
      ),
    );
  }
  ```
  
  - Cell的复用  
  ```dart
  Widget _homeBody(){
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index){
        return EveryCell();
      },
    );
  }
  ```
  
- **feed_list.dart**  
对Cell的实现，通过container容器实现，在container中添加多个container以实现多个组件组合的效果  
一个Cell为一个Container，其中包括6个Container，采用Wrap流式布局  
6个Container分别对应为上方头像，昵称，中间图片，左下角图标，下方头像，评论框  
下面给出中间图片的实现代码，其实现了页面跳转功能：  
```dart
Container(
  child: FlatButton(
    onPressed: () {
      Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return DetailContent();
        }));
    },
    child: (
      Image.asset("resources/timg.jpeg")
    ),
  ),
),
```

- **feed_list.dart**  
只需使用脚手架来实现AppBar与body即可，body仅为图片，通过设置Container大小实现覆盖整个页面
```dart
import 'package:flutter/material.dart';

class DetailContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Andrew"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: (
            Image.asset("resources/timg.jpeg")
        ),
      ),
    );
  }
}
```

- **电量获取的API在Android端的实现
实现参考[官方教程](https://book.flutterchina.club/chapter12/android_implement.html)  
这里采用kotlin实现，文件在android/app/src/main/kotlin下的MainActivity中

### (3)实验遇到的困难以及解决思路
实验遇到的困难还是比较多的，一开始搭建环境时由于jdk版本过高导致出错，在修改各种配置文件无果后选择卸载高版本jdk安装jdk8；后来在实现电量获取时也遇到了困难，由于只在flutter进行了实现，而Android和ios端都没有进行实现，导致报错，后来在官方教程中找到了相应的实现方法才得以解决


## 四、实验思考及感想
这次作业相比于上一次OC编写的作业要简单太多，不管是各种控件之间的关系、控件的种类还是代码量，并且编写一份代码即可在双端运行，让人感受到了flutter的强大。尤其是中文官网自带的dart教程，各种控件的参数和使用都有详细讲解，并且给予了一个完整的app例子。

