#import "FYAPPPieChartView.h"
#import "UIColor+FYColor.h"

@interface FYAPPPieChartView ()

@property (strong, nonatomic) NSArray *arr;

@end

@implementation FYAPPPieChartView

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
    // 算出自己视图中心点
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    // 设置起始弧度
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    for (int i = 0; i < self.arr.count; i++) {
        // 用自己的比例乘以 M_PI * 2, 就得到自身应该占据的弧度
        // 因为 0 度永远是 3 点钟的方向, 所以, 再画扇形的时候, 不能简单的用弧度来作为结束弧度
        // 应该把之前结束弧度加上来
        endAngle += [self.arr[i] floatValue] / total * 2 * M_PI;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:startAngle endAngle:endAngle clockwise:YES];
        // 添加到中心点的线
        [path addLineToPoint:center];
        // 随机颜色
        [[UIColor fy_colorRandom] set];
        // 填充
        [path fill];
        // 下一次的起始弧度, 等于上一次结束弧度
        startAngle = endAngle;
    }
}

@end
