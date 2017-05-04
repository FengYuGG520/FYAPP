#import <UIKit/UIKit.h>

@interface NSAttributedString (FYProText)

/**
 得到上下排列的属性文本

 @param img 图像
 @param imgWH 图像宽和高
 @param title 标题文字
 @param fontSize 标题文字大小
 @param titleColor 标题颜色
 @param spacing 图像和标题间距
 @return 属性文本
 */
+ (instancetype)fy_proImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;

@end
