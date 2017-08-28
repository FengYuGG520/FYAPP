#import <UIKit/UIKit.h>

@interface UINavigationController (FYNavigationController)

/**
 导航栏初始化操作: 1. 去掉导航栏下面的分割线 2. 去掉导航条半透明效果 3. 设置导航栏 item 文字颜色 4. 设置导航栏标题文字颜色 5. 设置导航栏背景颜色 6. 设置导航栏的背景图片

 @param line 1. 去掉导航栏下面的分割线
 @param trans 2. 去掉导航条半透明效果
 @param itemTxtColor 3. 设置导航栏 item 文字颜色
 @param titleTxtColor 4. 设置导航栏标题文字颜色
 @param titleBackColor 5. 设置导航栏背景颜色
 @param imgName 6. 设置导航栏的背景图片
 */
- (void)fy_navLine:(BOOL)line trans:(BOOL)trans itemTxtColor:(UIColor *)itemTxtColor titleTxtColor:(UIColor *)titleTxtColor titleBackColor:(UIColor *)titleBackColor backImg:(NSString *)imgName;

/**
 去掉导航栏下面的分割线
 */
- (void)fy_navLine;

/**
 去掉导航条半透明效果
 */
- (void)fy_navTrans;

/**
 设置导航栏 item 文字颜色

 @param color item 文字颜色
 */
- (void)fy_navItemTxtColor:(UIColor *)color;

/**
 设置导航栏标题文字颜色

 @param color 标题文字颜色
 */
- (void)fy_navTitleTxtColor:(UIColor *)color;

/**
 设置导航栏背景颜色

 @param color 导航栏背景颜色
 */
- (void)fy_navTitleBackColor:(UIColor *)color;

/**
 设置导航栏的背景图片

 @param imgName 背景图片名
 */
- (void)fy_navBackImg:(NSString *)imgName;

@end
