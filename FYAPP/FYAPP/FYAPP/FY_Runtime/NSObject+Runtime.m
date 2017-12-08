//
//  NSObject+Runtime.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

// 获取对象所有的属性
- (NSArray *)getPropertylist
{
    NSMutableArray *arr = [NSMutableArray array];
    // 0. 属性的数量
    unsigned int count = 0;
    // 1. 获取类所有的属性
    // 第一个参数:哪一个类  第二个参数:用于接收属性的数量的地址 返回值是一个结构体数组
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    // 2. 遍历属性数组, 获取属性的详细信息
    for (int i =0; i<count; i++) {
        objc_property_t property = propertyList[i];
        
        // 3. 获取属性的名称
        const char *name = property_getName(property);
        // c字符串转成oc字符串
        NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
        
        [arr addObject:nameStr];
    }
    
    // C对象都需要手动释放(一般带*需要释放)
    free(propertyList);
    
    return [arr copy];
}


// 获取对象所有属性及属性的值 key(属性)=value(值)
- (NSArray <NSDictionary *>*)getPropertyAndValueList
{
    NSMutableArray *arr = [NSMutableArray array];
    // 0 属性的数量
    unsigned int count = 0;
    // 1. 获取类所有的属性
    // 第一个参数:哪一个类  第二个参数:用于接收属性的数量的地址 返回值是一个结构体数组
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    // 2. 遍历属性数组,获取属性的详细信息
    for (int i =0; i<count; i++) {
        objc_property_t property = propertyList[i];
        
        // 3. 获取属性的名称
        const char *name = property_getName(property);
        // c字符串转成oc字符串
        NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
        
        // 4. 获取属性的值
        if ([self valueForKey:nameStr]) {
            // 通过kvc取值
            NSString *value = [self valueForKey:nameStr];
            NSDictionary *dic = @{nameStr:value};
            [arr addObject:dic];
        }
        
    }
    
    // C对象都需要手动释放(一般带*需要释放)
    free(propertyList);
    
    return [arr copy];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

// 获取对象所有的方法
- (NSArray *)getMethodlist
{
    NSMutableArray *arr = [NSMutableArray array];
    // 0 方法的数量
    unsigned int count = 0;
    // 1. 获取类所有的属性
    // 第一个参数:哪一个类  第二个参数:用于接收方法的数量的地址 返回值是一个结构体数组
    Method *methodList = class_copyMethodList([self class], &count);
    // 2. 遍历方法数组,获取方法的详细信息
    for (int i =0; i<count; i++) {
        Method method = methodList[i];
        
        // 3. 获取方法签名
        SEL sel =  method_getName(method);
        
        
        
        // 4. 获取方法名字符串
        const char *methodName = sel_getName(sel);
        
        // c字符串转成oc字符串
        NSString *methodStr = [[NSString alloc] initWithUTF8String:methodName];
        
        // 5. 获取方法的数量
        //        unsigned int argumentCount =  method_getNumberOfArguments(method);
        //        for (i = 0 ; i<argumentCount; i++) {
        //            char name;
        //            method_getArgumentType(method, i, &name, 8);
        //            NSLog(@"%c",name);
        //        }
        
        [arr addObject:methodStr];
    }
    
    // C对象都需要手动释放(一般带*需要释放)
    free(methodList);
    
    return [arr copy];
}

// 获取对象所有的成员变量
- (NSArray *)getIvarlist
{
    NSMutableArray *arr = [NSMutableArray array];
    // 0 成员变量的数量
    unsigned int count = 0;
    // 1. 获取类所有的属性
    // 第一个参数:哪一个类  第二个参数:用于接收属性的数量的地址 返回值是一个结构体数组
    Ivar *propertyList = class_copyIvarList([self class], &count);
    
    // 2. 遍历属性数组,获取属性的详细信息
    for (int i =0; i<count; i++) {
        Ivar property = propertyList[i];
        
        // 3. 获取属性的名称
        const char *name = ivar_getName(property);
        // c字符串转成oc字符串
        NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
        
        [arr addObject:nameStr];
    }
    
    // C对象都需要手动释放(一般带*需要释放)
    free(propertyList);
    
    return [arr copy];
}

@end
