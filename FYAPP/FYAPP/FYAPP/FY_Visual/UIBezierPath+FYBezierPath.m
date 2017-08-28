#import "UIBezierPath+FYBezierPath.h"
#import <objc/runtime.h>

const void *LineColor = "LineColor";

@implementation UIBezierPath (FYBezierPath)

// 添加一个 lineColor 属性
- (void)setLineColor:(UIColor *)lineColor {
    objc_setAssociatedObject(self, LineColor, lineColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)lineColor {
    return objc_getAssociatedObject(self, LineColor);
}

@end
