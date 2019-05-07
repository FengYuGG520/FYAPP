//
//  FY_Enum.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#ifndef FY_Enum_h
#define FY_Enum_h

/**
 *  无参数无返回值的代码块
 */
typedef void (^FYBlock)();

/**
 *  http 分隔符
 */
static NSString *FYHTTPBoundary = @"FYHTTPBoundary";

/**
 *  方向
 */
typedef enum {
    FY_Direction_Top = 0,   // 上
    FY_Direction_Left,      // 左
    FY_Direction_Bottom,    // 下
    FY_Direction_Right,     // 右
} FY_Direction;

/**
 *  沙盒路径
 */
typedef enum {
    FY_Path_Caches = 0,     // 缓存
    FY_Path_Documents,      // 文档
    FY_Path_tmp,            // 临时
    FY_Path_Preferences,    // 配置
} FY_Path;

/**
 *  数据
 */
typedef enum {
    FY_Data_String = 0,     // 字符串二进制数据
    FY_Data_Json,           // JSON二进制数据
    FY_Data_File,           // 上传文件
} FY_Data;

/**
 *  时间
 */
typedef struct {
    long year;      // 年
    long month;     // 月
    long day;       // 日
    long hour;      // 时
    long minute;    // 分
    long second;    // 秒
} FY_Time;

#endif
