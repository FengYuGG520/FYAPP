/**
 *   新特性界面使用方式:
 *       1. new
 *       2. 添加到父容器并布局
 *       3. 设置 图片 数组
 */

#import <UIKit/UIKit.h>

@interface FYAPPFeatureView : UIView

/**
 设置 (UIImage *) 图片数组
 */
@property (strong, nonatomic) NSArray<UIImage *> *imgs;

@end
