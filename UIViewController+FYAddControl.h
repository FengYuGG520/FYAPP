#import <UIKit/UIKit.h>

@interface UIViewController (FYAddControl)

/**
 添加子控制器, 并把子控制器的根视图添加到参数视图

 @param controller 子控制器
 @param view 参数视图
 */
- (void)fy_addController:(UIViewController *)controller viewTo:(UIView *)view;

@end
