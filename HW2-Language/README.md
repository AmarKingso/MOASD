### 实验报告
#### 运行结果截图
一次完整的运行结果：

![完整结果（上）](https://img-blog.csdnimg.cn/20190909214855342.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)
![完整结果（下）](https://img-blog.csdnimg.cn/20190909214920436.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

随机情况：

![随机情况](https://img-blog.csdnimg.cn/20190909214513646.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Rpb3NtYWlfa2luZ3Nv,size_16,color_FFFFFF,t_70)

---
#### 关键代码及解释
```Object-C
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

```Object-C

```
