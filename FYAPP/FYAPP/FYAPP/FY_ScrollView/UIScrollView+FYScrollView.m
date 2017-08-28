#import "UIScrollView+FYScrollView.h"

@implementation UIScrollView (FYScrollView)

- (void)fy_scrollBarNO {
    self.showsVerticalScrollIndicator = NO;// 禁用滚动条
    self.showsHorizontalScrollIndicator = NO;
}

- (void)fy_scrollBouncesNO {
    self.bounces = NO;// 禁用弹簧效果
}

- (void)fy_scrollPagingOpen {
    self.pagingEnabled = YES;// 开启分页
}

- (void)fy_scrollZoomMin:(CGFloat)min max:(CGFloat)max {
    self.minimumZoomScale = min;// 设置缩放最小倍数
    self.maximumZoomScale = max;// 设置缩放最大倍数
}

- (void)fy_scrollInsetT:(CGFloat)T L:(CGFloat)L B:(CGFloat)B R:(CGFloat)R {
    self.contentInset = UIEdgeInsetsMake(T, L, B, R);// 设置内容缩进 (此方法不会改变 contentSize 的值)
}

- (void)fy_scrollTo:(FY_Direction)FY_Direction_Enum animated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    if (FY_Direction_Enum == FY_Direction_Top) off.y = 0 - self.contentInset.top;
    if (FY_Direction_Enum == FY_Direction_Left) off.x = 0 - self.contentInset.left;
    if (FY_Direction_Enum == FY_Direction_Right) off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    if (FY_Direction_Enum == FY_Direction_Bottom) off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

@end
