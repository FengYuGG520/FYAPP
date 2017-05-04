#import <UIKit/UIKit.h>

@interface UIScreen (fy_screen)

/**
 得到屏幕宽度

 @return 屏幕的宽度
 */
+ (CGFloat)fy_screenWith;

/**
 得到屏幕高度

 @return 屏幕的高度
 */
+ (CGFloat)fy_screenHeight;

/**
 得到分辨率

 @return 分辨率
 */
+ (CGFloat)fy_scale;

@end
