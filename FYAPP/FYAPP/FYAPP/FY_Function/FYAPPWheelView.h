/**
 *   使用方式:
 *       1. 类方法设置 轮播频率 轮播方向 有无分页指示器
 *       2. 添加到父容器并自动布局
 *       3. 设置图片 URL 路径的数组
 */

#import <UIKit/UIKit.h>
#import "FY_Enum.h"

@interface FYAPPWheelView : UIView

/**
 创建图片轮播器 HZ=轮播频率 FX=轮播方向 page=是否有分页

 @param HZ 轮播频率
 @param FX 轮播方向
 @param page 分页指示器
 @return 需要设置图片
 */
+ (instancetype)fy_wheelHZ:(double)HZ FX:(FY_Direction)FX page:(BOOL)page;

/**
 设置轮播图片 URL 路径的数组
 */
@property (strong, nonatomic) NSArray<NSURL *> *imgs;

@end
