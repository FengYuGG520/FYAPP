//
//  FYSingle.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

/**
 *  单例的三种创建模式
 */
#import <UIKit/UIKit.h>

@interface FYSingle : NSObject

+ (instancetype) FY;

/**
 *  用 GCD 实现单例模式
 *  单例设计模式的特点
 *  有一个全局访问点 (供全局实例化单例的类方法)
 *  单例保存在静态存储区
 *  在内存有且只有一份
 *  生命周期跟 APP 一样长
 */
// MARK: -> 懒汉模式单例 (只有在使用的时候才会创建)
+ (instancetype) sharedFY;
// MARK: -> 饿汉模式单例 (在类第一次被使用的时候创建)
+ (instancetype) defaultFY;

@end
