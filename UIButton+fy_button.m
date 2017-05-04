#import "UIButton+fy_button.h"
#import "NSAttributedString+FYProText.h"

@implementation UIButton (fy_button)

+ (instancetype)fy_btnText:(NSString *)text fontSize:(CGFloat)fontSize norColor:(UIColor *)norColor highColor:(UIColor *)highColor {
    
    UIButton *btn = [UIButton new];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:norColor forState:UIControlStateNormal];
    [btn setTitleColor:highColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    
    return btn;
}

+ (instancetype)fy_btnImgName:(NSString *)norName highName:(NSString *)highName {
    
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highName] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    return btn;
}

+ (instancetype)fy_btnProImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    
    UIButton *btn = [self new];
    NSAttributedString *att = [NSAttributedString fy_proImg:img imgWH:imgWH title:title fontSize:fontSize titleColor:titleColor spacing:spacing];
    [btn setAttributedTitle:att forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return btn;
}

@end
