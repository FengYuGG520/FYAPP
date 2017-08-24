#import "FYAPPStarsView.h"

@implementation FYAPPStarsView

- (void)setLevel:(CGFloat)level {
    _level = level;
    int fullCount = level;
    int halfCount = level - fullCount > 0;
    for (int i = 0; i < 5; i++) {
        UIImageView *iv = self.subviews[i];
        if (i < fullCount) {
            /**
             *   需要修改的满星图片
             */
            iv.image = [UIImage imageNamed:@"full_star"];
        } else if (halfCount) {
            /**
             *   需要修改的半星图片
             */
            iv.image = [UIImage imageNamed:@"half_star"];
        } else {
            /**
             *   需要修改的空星图片
             */
            iv.image = [UIImage imageNamed:@"empty_star"];
        }
    }
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    CGFloat a = self.bounds.size.height;
    for (int i = 0; i < 5; i++) {
        // 设置星星的边长 就是和 父类的宽度一样
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * a, 0, a, a)];
        [self addSubview:iv];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self setupUI];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

@end
