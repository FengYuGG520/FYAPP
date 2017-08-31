//
//  FYTools.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "FYTools.h"

@implementation FYTools

+ (CGFloat)fy_iOSVersion {
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+ (CGFloat)fy_lenInUI:(CGFloat)len {
    return len * [UIScreen fy_screenWith] / 375.00;
}

+ (NSString *)fy_path:(NSString *)path FY_Path:(FY_Path)FY_Path_Enum {
    // 根据枚举项得到沙盒路径
    NSString *pathStr = FY_Path_Enum == FY_Path_Caches ? @"/Library/Caches/" : FY_Path_Enum == FY_Path_Documents ? @"/Documents/" : FY_Path_Enum == FY_Path_tmp ? @"/tmp/" : @"/Library/Preferences/";
    // 拼接文件名并返回
    return [FYTools fy_pathStr:[NSString stringWithFormat:@"%@%@", pathStr, path]];
}

+ (NSString *)fy_pathStr:(NSString *)append {
    // 在沙盒路径后面追加一个传入的字符串并返回
    return [NSHomeDirectory() stringByAppendingString:append];
}

/**
 *  求两个时间差的函数:
 *  double timeCha = [date1 timeIntervalSinceDate:date2];
 *
 *  得到指定当前时间格式的字符串:
 *          // 1. 先创建一个NSDateFormatter对象, 这个对象的作用: 将一个日期转换成一个指定的格式
 *          NSDateFormatter *formatter1 = [NSDateFormatter new];
 *          formatter1.dateFormat = @"yyyy年MM月dd日 HH点mm分ss秒"; // hh:12小时制 HH:24小时制
 *          // 2. 不仅可以转换字符串的格式, 还会转换为当前系统所在时区的时间
 *          NSString *timeStr = [formatter1 stringFromDate:[NSDate date]]; // 获得当前时间字符串
 *          // 另一种得到秒数的方法
 *          NSDateFormatter *formatter2 = [NSDateFormatter new];
 *          // 下面指定只得到秒数的字符串格式
 *          formatter2.dateFormat = @"ss";
 *          // 拿到当前时间秒数, 如果需要用到可以把字符串转换成 int 类型
 *          NSString *secStr = [formatter2 stringFromDate:[NSDate date]];
 */
+ (FY_Time)fy_timeCurrent {
    /**
     *  先拿到当前系统的格林威治时间, 也就是0时区的时间, 北京是东8区, 所以得在这个时间上加 8 * 60 * 60秒
     *  我们可以用如下函数在初始化的时候 加上/减去 时间差
     *  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
     *  不过, 下面通过日历对象拿到日期对象组件的方法, 会帮我们把格林威治时间转换成当前系统时区的时间
     */
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];// 先创建一个日历对象
    // 根据当前格林威治时间拿到一个日期对象的组件 (这个日期对象组件里的时间, 就是当前系统的时间)
    NSDateComponents *comDate = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    FY_Time fy_time = {// 把日期对象组件分别给 FY_Time 结构体赋值
        (long)comDate.year,
        (long)comDate.month,
        (long)comDate.day,
        (long)comDate.hour,
        (long)comDate.minute,
        (long)comDate.second
    };
    return fy_time;// 返回 FY_Time
}

+ (void)fy_fpsShow {
    [[FYFPS sharedFPSIndicator] show];
}

@end
