# 中山大学数据科学与计算机学院本科生实验报告
| 课程名称 | 现代操作系统应用开发 |   任课老师   | 郑贵锋 |
| :------: | :------------------: | :----------: | :----: |
|   年级   |          17级         | 专业（方向） |    软件工程    |
|   学号   |      17343118     |     姓名     |     吴劢   |
|   电话   |      15013010440      |    Email     |    460450237@qq.com    |
| 开始日期 |       2019/10/22     |   完成日期   |   2019/10/23     |



## 一、实验题目
Flutter UI组件布局学习

## 二、实现内容
首先参考官方教程搭建Flutter开发环境：https://flutterchina.club/setup-macos/  
IDE推荐使用Android Studio。  

使用Flutter实现一个包含一个feed流页面的"社交App"，主页面如下：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191023235228178.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
 
manual中有演示视频，要求如下：

初始页面是应用启动后显示的第一个页面，可以上下滑动查看feed流。

 1. 初始页面顶部是一个AppBar。
 	- AppBar左边是一个摄像机Icon，要求距离左边12px边距，Icon图片使用Flutter自带的Icons.camera_alt，不需要加点击事件。
 	- AppBar右边是一个电量Icon组件和Text组件。距离右边12px边距，Icon图片使用Flutter自带的Icons.battery_unknown，点击事件在加分项里另说，如果不做加分项，AppBar右边这两个组件可以不用做。
 	- AppBar中间有一个Text，要求居中，文案为Helo.
2. 初始页面主体为一个ListView，ListView固定有六个Cell。每个Cell的样式都是相同的，要求必须复用。
 	- Cell上面有一个头像Image组件和昵称Text组件。头像图案使用manual文件夹里面的dog.jpeg。
 	- 所有边距都可以用16px或者10px来处理。
 	- Cell中间是一张图片，图片是manual文件夹里面的timg.jpeg。
 	- Cell图片下面是一个点赞按钮和评论按钮，点击事件不用做。点赞图案使用Flutter自带的Icons.favorite_border，评论图案使用Flutter自带的Icons.crop_3_2。
 	- Cell最下面是一个头像组件和一个文本框输入组件TextField。

3. 页面最下边是一个BottomAppBar组件，BottomAppBar里面用Row布局组件放五个Icon。分别是Icons.home，Icons.search，Icons.add_box，Icons.favorite，Icons.account_box。点击事件不用做。

## 三、实验结果

### (1)实验截图
该实验结果在真机上运行  

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191023235545898.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

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
