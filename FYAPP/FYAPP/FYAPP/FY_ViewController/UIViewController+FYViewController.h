#import <UIKit/UIKit.h>

@interface UIViewController (FYViewController)

/**
 添加子控制器, 并把子控制器的根视图添加到参数视图
 
 @param controller 子控制器
 @param view 参数视图
 */
- (void)fy_addController:(UIViewController *)controller viewTo:(UIView *)view;

/**
 设置控制器右边导航项的文字, 点击事件, 返回项的文字, 导航栏的文本
 
 @param RTitle 右边导航项的文字
 @param action 点击事件
 @param BTitle 返回项的文字
 @param navTitle 导航栏的文本
 */
- (void)fy_navRTitle:(NSString *)RTitle action:(SEL)action BTitle:(NSString *)BTitle navTitle:(NSString *)navTitle;

/**
 设置控制器 TabBar 文本, 默认图片, 选中图片
 
 @param title TabBar 文本
 @param norImg 默认图片
 @param selImg 选中图片
 */
- (void)fy_tabBarTitle:(NSString *)title norImg:(NSString *)norImg selImg:(NSString *)selImg;

/**
 隐藏控制器上面的导航条, 记得要在这个控制器 viewWillDisappear (即将消失的时候), 再把导航条显示出来
 */
- (void)fy_navCut;

/**
 去掉控制器底部的TabBar
 */
- (void)fy_tabCut;

/**
 接收多个手指触摸事件
 */
- (void)fy_touchMore;

/**
 让控制器进栈
 
 @param VC 控制器
 @param animated 是否要动画
 */
- (void)fy_pushVC:(UIViewController *)VC animated:(BOOL)animated;

/**
 让当前控制器出栈
 
 @param animated 是否要动画
 @return 控制器
 */
- (UIViewController *)fy_popVCAnimated:(BOOL)animated;

/**
 跳转到某个控制器
 
 @param VC 某个控制器
 @param animated 是否要动画
 @return 控制器数组
 */
- (NSArray<UIViewController *> *)popToVC:(UIViewController *)VC animated:(BOOL)animated;

/**
 拿到对应 sb 名字的对应 ID 的控制器, 如果 ID 为 nil 则返回 sb 里面带箭头的那个控制器

 @param sb 对应 sb 名字
 @param ID 对应 ID
 @return 控制器
 */
+ (instancetype)fy_vcInSB:(NSString *)sb ID:(NSString *)ID;

@end
