#import "UILabel+FYLabel.h"

@implementation UILabel (FYLabel)

+ (instancetype)fy_lblText:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *lbl = [self new];
    // 设置 Lbl 的文本 大小 颜色
    [lbl recordLblText:text color:color fontSize:size];
    lbl.numberOfLines = 0;
    [lbl sizeToFit];
    return lbl;
}

- (void)recordLblText:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)size {
    // 只是记录 Lbl 的文本 大小 颜色
    self.text = text;
    self.textColor = color;
    self.font = [UIFont systemFontOfSize:size];
}

@end
