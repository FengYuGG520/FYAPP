/**
 *  饼状图使用方式:
 *      1. 类方法创建, 并设置数据数组
 *      2. 添加到父视图, 布局并记录
 */

#import <UIKit/UIKit.h>

@interface FYAPPPieChartView : UIView

/**
 创建一个饼状图, 参数为数据
 
 @param arr 数据数组
 @return 饼状图
 */
+ (instancetype)fy_arr:(NSArray *)arr;

@end
