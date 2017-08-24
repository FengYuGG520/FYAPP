#import "FYAPPFeatureView.h"
#import "FYAutoLayout.h"

/**
 *   修改 button 图片
 *   修改 button 大小
 */
#define FYAPPFeatureButtonNormalImg @"common_more_black"
#define FYAPPFeatureButtonHighlightedImg @"common_more_white"
#define FYAPPFeatureButtonSize CGSizeMake(45, 25)

/**
 *   是否启用分页指示器
 *   修改分页指示器颜色
 */
#define FYAPPFeaturePageControl 1
#define FYAPPFeaturePageControlNormal [UIColor colorWithWhite:1 alpha:0.6]
#define FYAPPFeaturePageControlCurrent [UIColor colorWithWhite:0 alpha:0.4]

#define Btn_Tag 1314

@interface FYAPPFeatureView () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UIButton *btn;

@end

@implementation FYAPPFeatureView

- (instancetype)init {
    if (self = [super init]) [self setupUI];
    return self;
}

- (void)setImgs:(NSArray *)imgs {
    _imgs = imgs;
    // 设置 pageControl
    if (_pageControl) {
        [_pageControl fy_makeConstraints:^(FYConstraintMaker *make) {
            make.centerX.equalTo(self);
            /**
             *   设置 pageControl 的位置
             */
            make.bottom.equalTo(self.fy_bottom).offset(- self.bounds.size.height * 0.06);
        }];
        // 设置 pageControl 的点
        _pageControl.numberOfPages = imgs.count;
        _pageControl.currentPage = 0;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = _scrollView.bounds.size.width;
    // 把图片数组赋值给 UIImageView 的属性
    for (int i = 0; i < _imgs.count; i++) {
        UIImageView *iv = [UIImageView new];
        // 开启 UIImageView 的用户交互效果
        iv.userInteractionEnabled = YES;
        iv.image = _imgs[i];
        iv.frame = CGRectMake(i * width, 0, width, _scrollView.bounds.size.height);
        [_scrollView addSubview:iv];
    }
    _scrollView.contentSize = CGSizeMake((_imgs.count + 1) * width, 0);
    // 添加按钮
    [self addBtn];
}

- (void)addBtn {
    UIButton *btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:FYAPPFeatureButtonNormalImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:FYAPPFeatureButtonHighlightedImg] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    // 设置 tag 方便下面用到
    btn.tag = Btn_Tag;
    [btn fy_makeConstraints:^(FYConstraintMaker *make) {
        /**
         *   设置 btn 的位置
         */
        make.top.equalTo(self.fy_top).offset(self.bounds.size.height * 0.08);
        make.right.equalTo(self.fy_right).offset(- self.bounds.size.width * 0.08);
        make.size.fy_equalTo(FYAPPFeatureButtonSize);
    }];
    // 添加 btn 的响应事件
    [btn addTarget:self action:@selector(removeFeature) forControlEvents:UIControlEventTouchUpInside];
    _btn = btn;
}

// btn 的响应事件
- (void)removeFeature {
    int index = _scrollView.contentOffset.x / self.bounds.size.width;
    for (UIView *v in self.subviews) [v removeFromSuperview];
    UIImageView *iv = [UIImageView new];
    iv.image = _imgs[index];
    iv.frame = self.bounds;
    [self addSubview:iv];
    // 消失动画
    [self fy_animationVanishView:iv];
}

// 消失动画
- (void)fy_animationVanishView:(UIView *)iv {
    /**
     *   消失动画
     */
    [UIView animateWithDuration:0.6 animations:^{
        iv.transform = CGAffineTransformScale(iv.transform, 4, 4);
        iv.transform = CGAffineTransformRotate(iv.transform, M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            iv.transform = CGAffineTransformScale(iv.transform, 0.001, 0.001);
            iv.transform = CGAffineTransformRotate(iv.transform, M_PI);
            iv.alpha = 0.4;
        } completion:^(BOOL finished) {
            /**
             *   删除自己
             */
            [self removeFromSuperview];
        }];
    }];
}

// 搭建界面
- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    // 设置 UIScrollView
    UIScrollView *sv = [UIScrollView new];
    sv.delegate = self;
    sv.pagingEnabled = YES;
    sv.bounces = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    [self addSubview:sv];
    [sv fy_makeConstraints:^(FYConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    // 设置分页指示器
    _pageControl = nil;
    if (FYAPPFeaturePageControl) {
        UIPageControl *page = [UIPageControl new];
        page.pageIndicatorTintColor = FYAPPFeaturePageControlNormal;
        page.currentPageIndicatorTintColor = FYAPPFeaturePageControlCurrent;
        [self addSubview:page];
        _pageControl = page;
    }
    _scrollView = sv;
}

#pragma mark - 滚动代理方法
// 设置滚动过程中 pageControl 显示的页面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pageControl) {
        _pageControl.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
        // 设置 pageControl 的隐藏
        _pageControl.hidden = _imgs.count * _scrollView.frame.size.width - _pageControl.frame.origin.x < _scrollView.contentOffset.x;
        for (UIView *v in self.subviews) {
            // 设置 btn 的隐藏
            if (v.tag == Btn_Tag) v.hidden = _imgs.count * _scrollView.frame.size.width - _btn.frame.origin.x < _scrollView.contentOffset.x;
        }
    }
}

// 滚动停止时, 判断页面是否需要 删除自己
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page == _imgs.count) [self removeFromSuperview];
}

@end
