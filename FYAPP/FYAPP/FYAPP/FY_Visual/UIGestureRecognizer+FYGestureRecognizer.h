#import <UIKit/UIKit.h>

// MARK: - 手势记得要清 1 或清 0
@interface UIGestureRecognizer (FYGestureRecognizer)


@end

// 拖拽
@interface UIPanGestureRecognizer (FYPanGestureRecognizer)

/**
 获取手指移动偏移值, 已做清零操作

 @return 手指移动偏移值
 */
- (CGPoint)fy_panOffset;

@end

// 捏合
@interface UIPinchGestureRecognizer (FYPinchGestureRecognizer)

/**
 获取手指移动缩放值, 已做清1操作

 @return 手指移动缩放值
 */
- (CGFloat)fy_pinScale;

@end


