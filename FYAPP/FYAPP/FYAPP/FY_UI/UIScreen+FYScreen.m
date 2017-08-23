#import "UIScreen+FYScreen.h"

@implementation UIScreen (FYScreen)

+ (CGFloat)fy_screenWith {
    // 返回屏幕宽度
    return [self mainScreen].bounds.size.width;
}

+ (CGFloat)fy_screenHeight {
    // 返回屏幕高度
    return [self mainScreen].bounds.size.height;
}

+ (CGFloat)fy_screenScale {
    // 返回屏幕分辨率
    return [self mainScreen].scale;
}

+ (CGFloat)fy_1px {
    // 返回 1 像素
    return 1 / [self fy_screenScale];
}

@end
