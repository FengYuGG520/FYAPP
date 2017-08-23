#import <UIKit/UIKit.h>
#import "FY_Enum.h"

@interface UIScrollView (FYScrollView)

/**
 禁用滚动条
 */
- (void)fy_scrollBarNO;

/**
 禁用反弹效果
 */
- (void)fy_scrollBouncesNO;

/**
 开启分页
 */
- (void)fy_scrollPagingOpen;

/**
 设置缩放倍数
 
 @param min 最小缩放倍数
 @param max 最大缩放倍数
 */
- (void)fy_scrollZoomMin:(CGFloat)min max:(CGFloat)max;

/**
 设置内容缩进 (上, 左, 下, 右)
 
 @param T 上
 @param L 左
 @param B 下
 @param R 右
 */
- (void)fy_scrollInsetT:(CGFloat)T L:(CGFloat)L B:(CGFloat)B R:(CGFloat)R;

/**
 滚动 scrollView 到某个方向

 @param FY_Direction_Enum 方向
 @param animated 是否需要动画
 */
- (void)fy_scrollTo:(FY_Direction)FY_Direction_Enum animated:(BOOL)animated;

@end
