//
//  NSObject+FYNotificationCenter.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

/**
 *  代理: 都是1对1
 *  通知: 多对多
 *  NSNotificationCenter 是一个单例
 *  监听通知以后, 一定要记得在 dealloc 方法里移除通知
 */

#import "NSObject+FYNotificationCenter.h"

@implementation NSObject (FYNotificationCenter)

- (void)fy_notiName:(NSString *)name action:(SEL)action inObj:(id)obj {
    /*
     *   通知中心
     *   谁订阅消息
     *   消息收到后调用哪个方法
     *   订阅消息的名字, 传 nil 则代表这个对象任何消息都收
     *   订阅哪个对象发送消息, 传 nil 则代表任何对象的消息都收
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:name object:obj];
}

- (void)fy_notiRemove {
    // 让当前对象移除消息通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fy_notiPostName:(NSString *)name info:(NSDictionary *)info {
    /**
     *  参数1: 这条通知的名字
     *  参数2: 发送者是谁
     *  参数3: 附加信息 (其实就是你想传入多余数据)
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:info];
}

@end
