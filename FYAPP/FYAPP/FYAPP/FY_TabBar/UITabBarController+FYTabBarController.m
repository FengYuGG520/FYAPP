#import "UITabBarController+FYTabBarController.h"

@implementation UITabBarController (FYTabBarController)

- (void)fy_tabLine:(BOOL)line trans:(BOOL)trans selTxtColor:(UIColor *)color {
    if (line) [self fy_tabLine];
    if (trans) [self fy_tabTrans];
    if (color) [self fy_tabSelTxtColor:color];
}

- (void)fy_tabLine {
    // 去掉 TabBar 上面的分割线
    CGRect rect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}

- (void)fy_tabTrans {
    // 去掉 TabBar 透明效果
    self.tabBar.translucent = NO;
}

- (void)fy_tabSelTxtColor:(UIColor *)color {
    // 设置 TabBar 选中时字体颜色
    if (color) self.tabBar.tintColor = color;
}

@end
