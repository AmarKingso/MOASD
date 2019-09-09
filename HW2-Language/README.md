### 实验报告
#### 运行结果截图
一次完整的运行结果：

![完整结果（上）](https://img-blog.csdnimg.cn/20190909214855342.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![完整结果（下）](https://img-blog.csdnimg.cn/20190909214920436.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

随机情况：

![随机情况](https://img-blog.csdnimg.cn/20190909214513646.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

---
#### 关键代码及解释
```obj-C
/*Language类的定义*/
@interface Language : NSObject {

    NSInteger progress_tour;

    NSInteger progress_unit;

}

- (void)learnOneUnit;

- (NSInteger)getTour;

- (NSInteger)getUnit;

- (bool)isFinish;

- (NSString *)getName;

@end
```
上述代码为Language类的定义，其成员函数的作用分别为uint的自增以及tour相应地增加；获取当前tour；获取当前unit；判断是否完成学习；得到所要学习的语言的名字。其中getName用于实现多态。

```obj-C
@implementation English

- (NSString *)getName{

    return @"英语";

}

@end
```
上述代码为Language子类English的实现，以此实现多态，其他子类的实现以此类推
主函数（main.m）代码各部分都有注释进行解释，在此不做赘述

---
#### 学习收获
真正意义上的进入了object-c的学习，此次作业涉及到了object-c类的继承，多态，封装，；API的调用语法；基本变量类型与基础函数的使用。相比于上一次试探性的hello程序，更具有参考价值，让我大致熟悉了obj-c语言的语法，其实和c大同小异，并且带我复习了一下自己掌握的并不是很牢固的类的多态。额外的一些收获就是关于时间变量与函数的一些用法。
