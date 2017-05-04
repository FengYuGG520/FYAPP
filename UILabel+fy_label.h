#import <UIKit/UIKit.h>

@interface UILabel (fy_label)

/**
 创建 Lbl

 @param text 文本
 @param color 颜色
 @param size 字体大小
 @return 这样的Lbl
 */
+ (instancetype)fy_lblText:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)size;

@end
