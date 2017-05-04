/*
    使用方式:
        1. new
        2. 添加到父容器
        3. 自动布局
        4. [self layoutIfNeeded];
        5. 设置图片 URL 路径的数组
 
    可选设置:
        1. FYWheelHZ 轮播频率
        2. FYWheelFX 轮播方向 (上=1 下=2 左=3 右=4)
        3. FYOpenPage 分页指示器 (有=1 无=0)
 */

#define FYWheelHZ 2.5
#define FYWheelFX 2
#define FYOpenPage 1

#import <UIKit/UIKit.h>

@interface FYAPPWheelView : UIView

/**
 图片 URL 路径的数组
 */
@property (strong, nonatomic) NSArray<NSURL *> *imgs;

@end
