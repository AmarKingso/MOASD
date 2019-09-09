//
//  main.m
//  hw2
//
//  Created by Amar on 2019/9/9.
//  Copyright © 2019 Amar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Language.h"

int main(){
    int randperson = arc4random() % 3;
    int randlang = arc4random() % 4;
    NSString *person;       //要学习的人
    Language *lang;     //要学习的语言
    
    NSTimeInterval Daysecs = 24 * 60 * 60;
    NSDate *startday = [NSDate date];       //获取当前日期
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    
    /*随机选择学习的人*/
    switch(randperson){
        case 0:
            person = @"张三";
            break;
        case 1:
            person = @"李四";
            break;
        case 2:
            person = @"王五";
            break;
    }
    
    /*随机选择语言*/
    switch(randlang){
        case 0:
            lang = [English alloc];
            break;
        case 1:
            lang = [Japanese alloc];
            break;
        case 2:
            lang = [German alloc];
            break;
        case 3:
            lang = [Spanish alloc];
            break;
    }
    
    /*进行学习*/
    while(![lang isFinish]){
        int randday = arc4random() % 5 + 1;
        [lang learnOneUnit];
        NSString *date = [format stringFromDate:startday];      //得到所需日期格式
        
        NSLog(@"%@ %@ 学习%@ tour %ld unit %ld\n", person, date, [lang getName], [lang getTour], [lang getUnit]);
        startday = [startday addTimeInterval:randday * Daysecs];        //加上随机天数
        
    }
}
