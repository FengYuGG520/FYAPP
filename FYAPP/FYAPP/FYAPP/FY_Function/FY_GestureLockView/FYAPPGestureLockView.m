#import "FYAPPGestureLockView.h"
#import "NSArray+FYArray.h"
#import "UIButton+FYButton.h"

@interface FYAPPGestureLockViewModel : NSObject

// 按钮图片的模型
@property (copy, nonatomic) NSString *norImg;
@property (copy, nonatomic) NSString *highImg;
@property (copy, nonatomic) NSString *errImg;

@end

@implementation FYAPPGestureLockViewModel

@end

@interface FYAPPGestureLockView ()

@property (copy, nonatomic) NSString *pwd;
@property (strong, nonatomic) NSArray<FYAPPGestureLockViewModel *> *models;
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) NSMutableArray<UIButton *> *arrM;
@property (assign, nonatomic) CGPoint lastPoint;

@end

@implementation FYAPPGestureLockView

- (UIColor *)lineColor {
    if (!_lineColor) _lineColor = [UIColor whiteColor];
    return _lineColor;
}

- (NSMutableArray *)arrM {
    if (!_arrM) _arrM = [NSMutableArray new];
    return _arrM;
}

+ (instancetype)fy_Pwd:(NSString *)pwd plistName:(NSString *)plistName {
    return [[self alloc] initWithPwd:pwd plistName:plistName];
}

- (instancetype)initWithPwd:(NSString *)pwd plistName:(NSString *)plistName {
    if (self = [super init]) {
        _pwd = pwd;
        _models = [NSArray fy_plistName:plistName modelName:@"FYAPPGestureLockViewModel"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 实例化绘图对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置线条宽度
    path.lineWidth = 10;
    // 设置线条颜色
    // 统一设置填充和线条颜色
    [self.lineColor set];
    for (int i = 0; i < self.arrM.count; i++) {
        // 如果是第0个按钮, 那么就以它做起点
        if (!i) [path moveToPoint:self.arrM[i].center];
        else [path addLineToPoint:self.arrM[i].center];
    }
    // 在添加我们后面移动的线
    if (self.arrM.count > 0) [path addLineToPoint:self.lastPoint];
    // 设置拐角样式
    path.lineCapStyle = kCGLineCapRound;
    // 设置线头样式
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self fy_btnHigh:touches.anyObject];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    [self fy_btnHigh:t];
    // 设置最后那个点
    self.lastPoint = [t locationInView:self];
    // 重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 设置为最后一个按钮的中心点
    self.lastPoint = self.arrM.lastObject.center;
    // 判断密码是否正确
    NSMutableString *strM = [NSMutableString new];
    for (UIButton *btn in self.arrM) {
        [strM appendFormat:@"%zd", btn.tag];
    }
    if ([strM isEqualToString:self.pwd]) {
        NSLog(@"密码正确, 这里进行跳转操作");
    } else {
        // 1. 按钮变红
        for (UIButton *btn in self.arrM) {
            // btn 的特点: 永远只允许一个状态为 YES
            btn.highlighted = NO;
            btn.selected = YES;
        }
        // 2. 线变红
        self.lineColor = [UIColor redColor];
        /**
         *  时钟
         *  参数1: 等待多久
         *  参数2, 3: 时间一到调用哪个对象的哪个方法
         *  参数4: nil
         *  参数5: 是否重复
         */
        // NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval) target:(nonnull id) selector:(nonnull SEL) userInfo:(nullable id) repeats:(BOOL)];
        
        // 等待错误的时候不能让用户交互
        self.userInteractionEnabled = NO;
        
        /**
         *  多线程 GCD 实现 刷新
         *  参数1: 延迟多少秒执行
         *  参数2: 多少秒要执行什么代码
         */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 线条变回白色
            self.lineColor = [UIColor whiteColor];
            // 把选中按钮变为默认状态
            for (UIButton *btn in self.arrM) {
                btn.selected = NO;
            }
            // 错误完成, 开启用户交互
            self.userInteractionEnabled = YES;
            // 选中的按钮数组清空所有元素
            [self.arrM removeAllObjects];
            // 重绘
            [self setNeedsDisplay];
        });
    }
    // 重绘
    [self setNeedsDisplay];
}

- (void)fy_btnHigh:(UITouch *)t {
    CGPoint touchPoint = [t locationInView:self];
    for (UIButton *btn in self.subviews) {
        CGRect frame = btn.frame;
        // 这个函数可以判断参数2在不在参数1的范围内, 如果在, 返回 YES, 如果不在返回 NO
        BOOL result = CGRectContainsRect(frame, CGRectMake(touchPoint.x, touchPoint.y, 1, 1));
        // 除了要判断点的范围在这个 btn 之外
        // 还要判断这个按钮是否已经高亮
        // 只有在这个范围内, 并且没有高亮状态, 才让你高亮并添加到数组
        if (result && !btn.highlighted) {
            // 让 btn 高亮
            btn.highlighted = YES;
            // 把当前高亮的按钮添加到数组
            [self.arrM addObject:btn];
            break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setSubviews];
}

- (void)setSubviews {
    // 解决在 sb 中设置颜色, 但是重写 drawRect 方法后会变黑的问题, 就只能在代码中, 程序启动时设置一个颜色
    self.backgroundColor = [UIColor clearColor];
    // 设置列数
    int colnum = 3;
    // 获取当前视图宽度
    CGFloat viewW = self.bounds.size.width;
    // 创建 9 个 Btn
    for (int i = 0; i < 9; i++) {
        // 创建 btn
        UIButton *btn = [UIButton fy_btnImgName:self.models[0].norImg highName:self.models[0].highImg disableName:nil selName:self.models[0].errImg];
        // 设置这个后, 密码将从 1-9
        btn.tag = i + 1;
        // 让 btn 禁用用户交互
        btn.userInteractionEnabled = NO;
        // 计算间距
        CGFloat margin = (viewW - colnum *btn.bounds.size.width) / (colnum + 1);
        // 设置行, 列索引
        int rowIdx = i / colnum;
        int colIdx = i % colnum;
        // 设置 btn 坐标
        CGFloat x = margin + colIdx * (btn.bounds.size.width + margin);
        CGFloat y = margin + rowIdx * (btn.bounds.size.height + margin);
        // 设置 frame
        btn.frame = CGRectMake(x, y, btn.bounds.size.width, btn.bounds.size.height);
        [self addSubview:btn];
    }
}

@end
