//
//  NSObject+Runtime.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/objc-runtime.h>

@implementation NSObject (Runtime)

- (NSArray *)propsList {
    unsigned int count = 0;
    /**
     *  1: 类
     *  2: 成员变量的计数
     *  返回的是 C 语言的数组
     */
    Ivar *ivarList = class_copyIvarList([self class], &count);
    // 创建成员变量数组
    NSMutableArray *ivars = [NSMutableArray new];
    // 遍历数组
    for (int i = 0; i < count; i ++) {
        // 1. 根据下标获取成员变量
        Ivar ivar = ivarList[i];
        // 2. 获取成员变量的名称
        const char *cName = ivar_getName(ivar);
        // 3. 转换成 NSString
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [ivars addObject:name];
    }
    // 释放对象 free
    free(ivarList);
    return ivars.copy;
}

@end
