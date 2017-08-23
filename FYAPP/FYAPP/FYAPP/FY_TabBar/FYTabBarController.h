#import <UIKit/UIKit.h>
/**
 *  使用方式:
 *       1. 类方法创建, 给 _window 设置根控制器, 并给定 plist 文件名
 *       2. plist 文件是一个 NSArray 数组, 每个元素是一个字典 四个键名 必须是:
 *          a. viewController : (控制器类名)
 *          b. norImg : (默认 tabBarItem 图片名)
 *          c. selImg : (选中 tabBarItem 图片名)
 *          d. title : (tabBarItem 的标题)
 */
@interface FYTabBarController : UITabBarController

/**
 类方法创建 TabBar 并设置每个 tabBarItem 标题 默认图片 选中图片 控制器, 需要按照规范设置 plist 文件

 @param plist plist 文件名
 @return TabBar 架构
 */
+ (instancetype)fy_tabBarPlistName:(NSString *)plist;

/**
 高潮 (不建议使用)

 @return 框架
 */
+ (instancetype)FY;

@end
