//
//  FYTools.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FY_Enum.h"

#define fy_UISetLen(len) [FYTools fy_lenInUI:(len)]

@interface FYTools : NSObject

/**
 得到当前系统版本
 
 @return 当前系统版本
 */
+ (CGFloat)fy_iOSVersion;

/**
 根据 UI 给的相对于 4.7 英寸屏幕切的尺寸, 返回相对当前屏幕的尺寸
 
 @param len UI 给的相对于 4.7 英寸屏幕切的尺寸
 @return 相对当前屏幕的尺寸
 */
+ (CGFloat)fy_lenInUI:(CGFloat)len;

/**
 获得某文件的沙盒全路径, 参数1: 该文件名 参数2: 存到沙盒指定地方的枚举项
 
 @param path 文件名
 @param FY_Path_Enum 存到沙盒指定地方的枚举项
 @return 沙盒全路径
 */
+ (NSString *)fy_path:(NSString *)path FY_Path:(FY_Path)FY_Path_Enum;

/**
 得到当前这一秒的时间结构体 (年=year 月=month 日=day 时=hour 分=minute 秒=second)
 
 @return 当前时间结构体
 */
+ (FY_Time)fy_timeCurrent;

@end
