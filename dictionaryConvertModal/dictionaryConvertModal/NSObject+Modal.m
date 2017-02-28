//
//  NSObject+Modal.m
//  dictionaryConvertModal
//
//  Created by 冯亚运 on 17/2/27.
//  Copyright © 2017年 冯亚运. All rights reserved.
//
#import "NSObject+Modal.h"
#import <objc/message.h>
#import "Person.h"
@implementation NSObject (Modal)

/*
 1  取出类中的所有成员变量（用runtime）
 2  根据成员变量的名称去取出字典中的Value值
 3  然后根据kvc给模型中的属性赋值
 */

+ (instancetype)itemWithDic:(NSDictionary *)dic {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    // 获取调用的类成员变量的列表 然后开始便利
    Ivar *ivaList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivaList[i];
        //获取到带下划线的成员变量
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //去除下划线
        key = [key substringFromIndex:1];
        //根据成员变量的名称去字典中取出对应的value
        id value = dic[key];
        // 如果value是字典类型
        if ([value isKindOfClass:[NSDictionary class]]) {
            //取出成员变量的类型字符串
            NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            //取出成员变量的类型字符串中多余的字段删除了
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
              //根据成员变量的类型的类去变成对应类型一个类的对象
            value = [NSClassFromString(ivarType) itemWithDic:value];
      }
             // 如果value是数组类型
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(objectClassInArray)]) {
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf objectClassInArray][key];
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dic in value) {
                    // 字典转模型
                    id model =  [classModel itemWithDic:dic];
                    [arrM addObject:model];
                }
                // 把模型数组赋值给value
                value = arrM;
             }
        }
        //给模型中的属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
   return objc;
}

@end
