#import "FYAPPAnimaView.h"
#import "NSArray+FYArray.h"

@interface FYAPPAnimaView ()

@property (assign, nonatomic) CGFloat HZ;

@end

@implementation FYAPPAnimaView

/**
 *  默认每 1.5 秒播放一张
 */
- (instancetype)init {
    if (self = [super init]) [self setHZ:1.5];
    return self;
}

- (instancetype)initWithHZ:(CGFloat)HZ {
    if (self = [super init]) [self setHZ:HZ];
    return self;
}

- (void)setHZ:(CGFloat)HZ {
    _HZ = HZ;
    self.backgroundColor = [UIColor clearColor];
    if (HZ <= 0) _HZ = 0.1;
}

+ (instancetype)fy_animaHZ:(CGFloat)HZ {
    return [[self alloc] initWithHZ:HZ];
}

/**
 *  设置帧动画图片
 */
- (void)setImgs:(NSArray<NSURL *> *)imgs {
    // 调用 UIImage 类方法, 放入需要动画的图片数组, 并设置播放每张图片的频率
    self.image = [UIImage animatedImageWithImages:[NSArray fy_ImgArrWithURLArr:imgs] duration:_HZ * imgs.count];
}

@end
