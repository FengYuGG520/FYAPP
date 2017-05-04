#import "NSAttributedString+FYProText.h"

@implementation NSAttributedString (FYProText)

+ (instancetype)fy_proImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    
    NSDictionary *titleDic = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                               NSForegroundColorAttributeName : titleColor
                               };
    NSDictionary *spacDic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:spacing]
                              };
    
    NSTextAttachment *att = [NSTextAttachment new];
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
