#import <UIKit/UIKit.h>

@interface UIImage (FYImage)

/**
 Show Overview 图片平铺, 保留四个角, 四个数字在 0.0~1.0 之间, 返回一个平铺后的图片

 @param top 上
 @param left 左
 @param bottom 下
 @param right 右
 @return 平铺后的图片
 */
- (instancetype)fy_showOverviewT:(CGFloat)top L:(CGFloat)left B:(CGFloat)bottom R:(CGFloat)right;

/**
 把该图片名的渲染效果去掉, 并返回 (tabBarItem.selectedImage)

 @param name 需要去掉渲染效果的图片名
 @return 去掉渲染效果的图片
 */
+ (instancetype)fy_originalImgNamed:(NSString *)name;

/**
 根据 URL 路径直接拿到图片, 用于获取本地图片

 @return (UIImage *)
 */
+ (instancetype)fy_imgURL:(NSURL *)url;

@end
