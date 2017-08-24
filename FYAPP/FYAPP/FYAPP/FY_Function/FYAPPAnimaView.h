/**
 *  帧动画使用方式:
 *      1. 类方法设置 播放频率
 *      2. 添加到父容器并自动布局
 *      3. 设置图片 URL 路径的数组
 */

#import <UIKit/UIKit.h>

@interface FYAPPAnimaView : UIImageView

/**
 创建帧动画 HZ=播放频率

 @param HZ 播放频率
 @return 需要设置图片
 */
+ (instancetype)fy_animaHZ:(CGFloat)HZ;

/**
 设置播放图片 URL 路径的数组
 */
@property (strong, nonatomic) NSArray<NSURL *> *imgs;

@end
