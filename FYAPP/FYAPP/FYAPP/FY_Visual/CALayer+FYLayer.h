#import <QuartzCore/QuartzCore.h>

@interface CALayer (FYLayer)

/**
 设置 layer 开始三维前的准备 (远小近大的效果)
 */
- (void)start3D;

@end
