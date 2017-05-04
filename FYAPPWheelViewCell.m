#import "FYAPPWheelViewCell.h"

@interface FYAPPWheelViewCell ()

@property (weak, nonatomic) UIImageView *imgView;

@end

@implementation FYAPPWheelViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setImg:(NSURL *)img {
    
    _img = img;
    NSData *data = [NSData dataWithContentsOfURL:img];
    _imgView.image = [UIImage imageWithData:data];
}

- (void)setupUI {
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:iv];
    
    _imgView = iv;
}

@end
