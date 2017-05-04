#import "UILabel+fy_label.h"

@implementation UILabel (fy_label)

+ (instancetype)fy_lblText:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)size {
    
    UILabel *lbl = [UILabel new];
    lbl.text = text;
    lbl.textColor = color;
    lbl.font = [UIFont systemFontOfSize:size];
    lbl.numberOfLines = 0;
    [lbl sizeToFit];
    /*
        文本居中
        lbl.textAlignment = NSTextAlignmentCenter;
     */
    
    return lbl;
}

@end
