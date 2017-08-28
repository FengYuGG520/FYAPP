/**
 *  侧滑控制器:
 *      1. 类方法创建, 设置左侧控制器和右侧控制器作为自己的子控制器
 *      2. 作为根控制器
 */

#import <UIKit/UIKit.h>

@interface FYAPPSliderController : UIViewController

/**
 类方法创建, 设置左侧控制器和右侧控制器作为自己的子控制器

 @param leftVC 左控制器
 @param rightVC 右控制器
 @return 实现侧滑的控制器
 */
+ (instancetype)fy_LeftVC:(UIViewController *)leftVC rightVC:(UIViewController *)rightVC;

@end
