#import "UIScreen+fy_screen.h"

@implementation UIScreen (fy_screen)

+ (CGFloat)fy_screenWith {
    
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)fy_screenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)fy_scale {
    
    return [UIScreen mainScreen].scale;
}

@end
