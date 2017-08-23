//
//  NSObject+FYNotificationCenter.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FYNotificationCenter)

/**
 订阅消息 参数1: 消息名 参数2: 收到消息执行的事件 参数3: 发送消息的对象
 
 @param name 消息名
 @param action 收到消息执行的事件 (传 nil 则代表这个对象任何消息都收)
 @param obj 发送消息的对象 (传 nil 则代表任何对象的消息都收)
 */
- (void)fy_notiName:(NSString *)name action:(SEL)action inObj:(id)obj;

/**
 移除消息中心
 */
- (void)fy_notiRemove;

/**
 发送消息 参数1: 消息名 参数2: 附加信息
 
 @param name 消息名
 @param info 附加信息
 */
- (void)fy_notiPostName:(NSString *)name info:(NSDictionary *)info;

@end
