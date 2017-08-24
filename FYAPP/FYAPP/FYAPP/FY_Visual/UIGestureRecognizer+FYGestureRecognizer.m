#import "UIGestureRecognizer+FYGestureRecognizer.h"

@implementation UIGestureRecognizer (FYGestureRecognizer)


@end

@implementation UIPanGestureRecognizer (FYPanGestureRecognizer)

- (CGPoint)fy_panOffset {
    // 获取手指移动的偏移值
    CGPoint offset = [self translationInView:self.view];
    // 立即清 0, 意思就是以已经移动后的位置作为参照起点
    [self setTranslation:CGPointZero inView:self.view];
    return offset;
}

@end

@implementation UIPinchGestureRecognizer (FYPinchGestureRecognizer)

- (CGFloat)fy_pinScale {
    // 获取手指捏合的比例
    CGFloat scale = self.scale;
    // 立即清 1, 意思就是以捏合后的比例作为初始比例
    self.scale = 1;
    return scale;
}

@end
