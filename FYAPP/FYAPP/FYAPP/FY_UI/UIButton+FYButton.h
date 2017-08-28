#import <UIKit/UIKit.h>

@interface UIButton (FYButton)

/**
 创建文本按钮
 
 @param text 文本
 @param fontSize 字体大小
 @param norColor 默认颜色
 @param highColor 高亮颜色
 @return 这样的按钮
 */
+ (instancetype)fy_btnText:(NSString *)text fontSize:(CGFloat)fontSize norColor:(UIColor *)norColor highColor:(UIColor *)highColor;

/**
 创建图片按钮, 不设置该状态下的图片, 传 nil
 
 @param norName 默认图片
 @param highName 高亮图片
 @param disableName 禁用图片
 @param selName 选中图片
 @return 这样的按钮
 */
+ (instancetype)fy_btnImgName:(NSString *)norName highName:(NSString *)highName disableName:(NSString *)disableName selName:(NSString *)selName;

/**
 创建图片文本的属性按钮
 
 @param img 图片
 @param imgWH 图片宽高
 @param title 文本
 @param fontSize 文本大小
 @param titleColor 文本颜色
 @param spacing 图片和文本间距
 @return 图片文本属性按钮
 */
+ (instancetype)fy_btnImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;

@end
