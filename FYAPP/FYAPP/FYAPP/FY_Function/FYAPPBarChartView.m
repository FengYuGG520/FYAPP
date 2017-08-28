#import "FYAPPBarChartView.h"
#import "UIColor+FYColor.h"

@interface FYAPPBarChartView ()

@property (strong, nonatomic) NSArray *arr;

@end

@implementation FYAPPBarChartView

+ (instancetype)fy_arr:(NSArray *)arr {
    return [[self alloc] initWithArr:arr];
}

- (instancetype)initWithArr:(NSArray *)arr {
    if (self = [super init]) _arr = arr;
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 计算总和
    CGFloat total = 0;
    for (int i = 0; i < self.arr.count; i++) total += [self.arr[i] floatValue];
    // 算宽度
    CGFloat width = rect.size.width / (self.arr.count * 2 - 1);
    // 创建绘图对象
    for (int i = 0; i < self.arr.count; i++) {
        // 计算高度 = 总高度 * 数据比例
        CGFloat height = rect.size.height * ([self.arr[i] floatValue] / total);
        // 计算 x, y
        CGFloat y = rect.size.height - height;
        CGFloat x = i * 2 * width;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, width, height)];
        [[UIColor fy_colorRandom] set];
        [path fill];
    }
}

@end
