//
//  FYSingle.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "FYSingle.h"

@implementation FYSingle

// 普通模式 (线程是不安全的)
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static id instance = nil;
    if (!instance) instance = [super allocWithZone:zone];
    return instance;
}

+ (instancetype) FY {
    return [self new];
}

/*
 *    懒汉模式单例
 *        只有在使用的时候才会创建 (线程是安全的)
 */
+ (instancetype)sharedFY {
    
    static id instance;
    
    static dispatch_once_t onceDispatch;
    dispatch_once(&onceDispatch, ^{
        
        instance = [self new];
    });
    
    return instance;
}

/*
 *    饿汉模式单例
 *        initialize 会在类第一次被使用的时候创建 (线程是安全的)
 */
static id instance;

+ (void)initialize {
    
    instance = [self new];
}

+ (instancetype)defaultFY {
    
    return instance;
}

@end
