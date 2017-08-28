//
//  NSObject+Runtime.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

/**
 获取该对象的所有属性列表
 
 @return 该对象的所有属性列表
 */
- (NSArray *)propsList;

@end
