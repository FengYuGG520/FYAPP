#import "UIButton+FYButton.h"

@interface NSAttributedString (FYAttributedString)
+ (instancetype)fy_proImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;
@end

@implementation UIButton (FYButton)

+ (instancetype)fy_btnText:(NSString *)text fontSize:(CGFloat)fontSize norColor:(UIColor *)norColor highColor:(UIColor *)highColor {
    UIButton *btn = [self new];
    [btn setTitle:text forState:UIControlStateNormal];// btn 的默认文字
    if (norColor) [btn setTitleColor:norColor forState:UIControlStateNormal];// btn 的两个状态下的文字颜色
    if (highColor) [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];// btn 的字体大小
    [btn sizeToFit];// 自动调整 btn 的大小
    return btn;
}

+ (instancetype)fy_btnImgName:(NSString *)norName highName:(NSString *)highName disableName:(NSString *)disableName selName:(NSString *)selName {
    UIButton *btn = [self new];
    // 设置 btn 在不同状态下的图片
    if (norName) [btn setImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    if (highName) [btn setImage:[UIImage imageNamed:highName] forState:UIControlStateHighlighted];
    if (disableName) [btn setImage:[UIImage imageNamed:disableName] forState:UIControlStateDisabled];
    if (selName) [btn setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    // 自动调整 btn 的大小
    [btn sizeToFit];
    return btn;
}

+ (instancetype)fy_btnImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    UIButton *btn = [self new];
    // 根据文本属性, 设置 btn 的文本属性
    NSAttributedString *att = [NSAttributedString fy_proImg:img imgWH:imgWH title:title fontSize:fontSize titleColor:titleColor spacing:spacing];
    [btn setAttributedTitle:att forState:UIControlStateNormal];
    // 设置文本居中
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    return btn;
}

@end

@implementation NSAttributedString (FYAttributedString)

// 根据传入的数据, 设置图片文本由上到下的文本属性字符串
+ (instancetype)fy_proImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    NSDictionary *titleDic = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                               NSForegroundColorAttributeName : titleColor
                               };
    NSDictionary *spacDic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:spacing]
                              };
    NSTextAttachment *att = [self new];
    att.image = img;
    att.bounds = CGRectMake(0, 0, imgWH, imgWH);
    NSAttributedString *imgText = [NSAttributedString attributedStringWithAttachment:att];
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacDic];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDic];
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imgText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    return attM.copy;
}

@end
