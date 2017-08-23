#import <UIKit/UIKit.h>

@interface UITabBarController (FYTabBarController)

/**
 TabBar 初始化操作: 1. 去掉 TabBar 上面的分割线 2. 去掉 TabBar 透明效果 3. 设置 TabBar 选中时字体颜色

 @param line 1. 去掉 TabBar 上面的分割线
 @param trans 2. 去掉 TabBar 透明效果
 @param color 3. 设置 TabBar 选中时字体颜色
 */
- (void)fy_tabLine:(BOOL)line trans:(BOOL)trans selTxtColor:(UIColor *)color;

/**
 去掉 TabBar 上面的分割线
 */
- (void)fy_tabLine;

/**
 去掉 TabBar 透明效果
 */
- (void)fy_tabTrans;

/**
 设置 TabBar 选中时字体颜色

 @param color TabBar 选中时字体颜色
 */
- (void)fy_tabSelTxtColor:(UIColor *)color;

@end
