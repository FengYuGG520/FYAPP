#import <UIKit/UIKit.h>

@interface UILabel (FYLabel)

/**
 创建 Lbl
 
 @param text 文本
 @param color 颜色
 @param size 字体大小
 @return 这样的Lbl
 */
+ (instancetype)fy_lblText:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)size;

/**
 只是记录 Lbl 文本, 颜色, 字体大小

 @param text 文本
 @param color 颜色
 @param size 字体大小
 */
- (void)recordLblText:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)size;

@end
