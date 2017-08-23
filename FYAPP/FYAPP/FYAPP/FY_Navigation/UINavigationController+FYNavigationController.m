#import "UINavigationController+FYNavigationController.h"

@implementation UINavigationController (FYNavigationController)

- (void)fy_navLine:(BOOL)line trans:(BOOL)trans itemTxtColor:(UIColor *)itemTxtColor titleTxtColor:(UIColor *)titleTxtColor titleBackColor:(UIColor *)titleBackColor backImg:(NSString *)imgName {
    if (line) [self fy_navLine];
    if (trans) [self fy_navTrans];
    if (itemTxtColor) [self fy_navItemTxtColor:itemTxtColor];
    if (titleTxtColor) [self fy_navTitleTxtColor:titleTxtColor];
    if (titleBackColor) [self fy_navTitleBackColor:titleBackColor];
    if (imgName) [self fy_navBackImg:imgName];
}

- (void)fy_navLine {
    // 去掉导航栏下面的分割线
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)fy_navTrans {
    // 去掉导航条半透明效果
    self.navigationBar.translucent = NO;
}

- (void)fy_navItemTxtColor:(UIColor *)color {
    // 设置导航栏 item 文字颜色
    if (color) self.navigationBar.tintColor = color;
}

- (void)fy_navTitleTxtColor:(UIColor *)color {
    // 设置导航栏标题文字颜色
    if (color) self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : color};
}

- (void)fy_navTitleBackColor:(UIColor *)color {
    // 设置导航栏背景颜色
    if (color) self.navigationBar.barTintColor = color;
}

- (void)fy_navBackImg:(NSString *)imgName {
    // 设置导航栏的背景图片
    if (imgName) [self.navigationBar setBackgroundImage:[UIImage imageNamed:imgName] forBarMetrics:UIBarMetricsDefault];
}

@end
