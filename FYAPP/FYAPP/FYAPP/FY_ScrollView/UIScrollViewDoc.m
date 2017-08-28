#import <UIKit/UIKit.h>
// 实现滚动 需 1. 添加内容 2. 设置 contentSize (原理: 改变的是 scrollView 的 bounds)
// 实现缩放 需 1. 设置代理, 遵守协议 2. 设置缩放倍数 3. 实现 viewForZooming 代理方法, 返回一个要缩放的视图 (原理: 改变的是被缩放那个视图的 transform)
@interface UIScrollViewDoc : NSObject <UIScrollViewDelegate>
// 相关属性:
// pagingEbable    分页
// contentSize     滚动范围
// contentInset    文本缩进
// contentOffset   已经滚动的偏移值
@end
@implementation UIScrollViewDoc
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {}// 正在滚动
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {}// 正在缩放
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {}// 开始滚动
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {}// 拖拽结束 (松手后)
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {}// 滚动停止
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {} // 当调用 setContentOffset/scrollRectVisible:animated: finishes 如果不在动画中不能调用
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {return nil;}// 返回缩放视图
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {}// 开始缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {}// 结束缩放
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {return 0;}// 默认 YES
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {}
@end
