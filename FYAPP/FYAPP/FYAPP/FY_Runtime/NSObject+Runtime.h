//
//  NSObject+Runtime.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 运行时 runtime 的本质就是用一组指针去记录一个类的细节
/// 运行时的作用让闭源的 ios 变得开源

// OC 对象的指针组成
// 类: class ---- isa指针
// 属性: property (最多)
// 方法: Method ---- IMP指针 (很多)
// 成员变量: ivar指针 (很少)
// 协议: protocol (极少)

@interface NSObject (Runtime)

// 获取对象所有的属性
- (NSArray *)getPropertylist;

// 获取对象所有属性及属性的值  key(属性)=value(值)
- (NSArray <NSDictionary *>*)getPropertyAndValueList;

// 获取对象所有的方法
- (NSArray *)getMethodlist;

// 获取对象所有的成员变量
- (NSArray *)getIvarlist;

@end
