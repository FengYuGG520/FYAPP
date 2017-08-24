#import "FYAPPWheelView.h"
#import "FYAutoLayout.h"

/**
 *   这里可以修改分页指示器颜色
 *   第一个: 其他点的颜色
 *   第二个: 当前点的颜色
 */
#define FYAPPWheelPageControlNormal [UIColor colorWithWhite:1 alpha:0.6]
#define FYAPPWheelPageControlCurrent [UIColor colorWithWhite:0 alpha:0.4]


@interface FYAPPWheelViewCell : UICollectionViewCell

@property (strong, nonatomic) NSURL *img;

@end

@interface FYAPPWheelViewCellLayout : UICollectionViewFlowLayout

@end

/**
 *  Cell 类
 */
@interface FYAPPWheelViewCell ()

@property (weak, nonatomic) UIImageView *iv;

@end

@implementation FYAPPWheelViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self setupUI];
    return self;
}

- (void)setImg:(NSURL *)img {
    _img = img;
    NSData *d = [NSData dataWithContentsOfURL:img];
    // 根据 URL 拿到图片
    _iv.image = [UIImage imageWithData:d];
}

- (void)setupUI {
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:iv];
    _iv = iv;
}

@end

@implementation FYAPPWheelViewCellLayout

// 设置 Cell 布局
- (void)prepareLayout {
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.itemSize = self.collectionView.frame.size;
}

@end

#define wheelCount 3

static NSString *wheelCell = @"wheelCell";

@interface FYAPPWheelView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (assign, nonatomic) double HZ;
@property (assign, nonatomic) FY_Direction FX;
@property (assign, nonatomic) BOOL page;

@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation FYAPPWheelView

// 类方法极速创建轮播器
+ (instancetype)fy_wheelHZ:(double)HZ FX:(FY_Direction)FX page:(BOOL)page {
    return [[self alloc] initWithHZ:HZ FX:FX page:page];
}

- (instancetype)init {
    if (self = [super init]) {
        /**
         *  通过 new 出来
         *  默认频率: 2.0
         *  默认方向: 右
         *  默认无分页指示器
         */
        [self setHZ:2.0];
        [self setFX:FY_Direction_Right];
        [self setPage:NO];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithHZ:(double)HZ FX:(FY_Direction)FX page:(BOOL)page {
    if (self = [super init]) {
        [self setHZ:HZ];
        [self setFX:FX];
        [self setPage:page];
        [self setupUI];
    }
    return self;
}

/**
 *   默认轮播频率为 2.0
 *   最快轮播频率为 0.4
 */
- (void)setHZ:(double)HZ {
    _HZ = HZ;
    if (HZ <= 0) {
        _HZ = 2.0;
    } else if (HZ <= 0.4) {
        _HZ = 0.4;
    }
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    // 设置 UICollectionView 里面 Cell 的布局
    FYAPPWheelViewCellLayout *layout = [FYAPPWheelViewCellLayout new];
    // 滚动方向
    layout.scrollDirection = (_FX == FY_Direction_Top || _FX == FY_Direction_Bottom) ? 0 : 1;
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    // 注册 Cell
    [cv registerClass:[FYAPPWheelViewCell class] forCellWithReuseIdentifier:wheelCell];
    cv.pagingEnabled = YES;
    cv.bounces = NO;
    cv.showsHorizontalScrollIndicator = NO;
    cv.showsVerticalScrollIndicator = NO;
    cv.dataSource = self;
    cv.delegate = self;
    [self addSubview:cv];
    [cv fy_makeConstraints:^(FYConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    // 记录
    _collectionView = cv;
    _pageControl = nil;
    if (_page) {
        UIPageControl *pg = [UIPageControl new];
        pg.pageIndicatorTintColor = FYAPPWheelPageControlNormal;
        pg.currentPageIndicatorTintColor = FYAPPWheelPageControlCurrent;
        [self addSubview:pg];
        _pageControl = pg;
    }
}

// 开始滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止计时器工作
    _timer.fireDate = [NSDate distantFuture];
}

// 结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 开启计时器工作
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:_HZ * 1.2];
}

// 滚动完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取到当前屏幕上可见 cell 对应的索引
    NSIndexPath *index = [self.collectionView indexPathsForVisibleItems].firstObject;
    // 如果是第 0 组或最后一组, 那么需要滚到中间那组去
    if (index.section == 0 || index.section == wheelCount - 1) {
        // 把这个 cell 替换为中间那组相同索引的 cell
        NSIndexPath *sIndex = [NSIndexPath indexPathForItem:index.item inSection:wheelCount / 2];
        // 不给动画效果
        [self.collectionView scrollToItemAtIndexPath:sIndex atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

// 用动画方式滚动完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

// 分页指示器滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = 0;
    // 设置 pageControl 当前显示的点
    page = (_FX == FY_Direction_Top || _FX == FY_Direction_Bottom) ? (int)(scrollView.contentOffset.y / _collectionView.bounds.size.height + 0.5) % wheelCount : (int)(scrollView.contentOffset.x / _collectionView.bounds.size.width + 0.5) % wheelCount;
    _pageControl.currentPage = page;
}

// 返回组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return wheelCount;
}

// 返回单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imgs.count;
}

// 返回单元格
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FYAPPWheelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:wheelCell forIndexPath:indexPath];
    cell.img = _imgs[indexPath.item];
    return cell;
}

- (void)setImgs:(NSArray<NSURL *> *)imgs {
    _imgs = imgs;
    if (_pageControl) {
        _pageControl.numberOfPages = imgs.count;
        [_pageControl fy_makeConstraints:^(FYConstraintMaker *make) {
            // 进行这种布局一定要让父视图完成布局
            make.centerX.equalTo(self);
            make.height.equalTo(self.fy_width).multipliedBy(0.015);
            make.bottom.equalTo(self.fy_bottom).offset(- self.bounds.size.height * 0.15);
        }];
    }
    [_collectionView reloadData];
    /**
     *   参数1: 多久触发一次 (单位 秒)
     *   参数2: 哪个对象来处理
     *   参数3: 触发事件时, 来调用哪个方法
     *   参数4: 给处理事件的方法的参数, 这里传 nil
     *   参数5: 是否重复, 为 YES 则一直重复, 为 NO 则只执行一次
     */
    _timer = [NSTimer timerWithTimeInterval:_HZ target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    /**
     *   需要把 timer 添加到消息循环里才有用
     *   NSDefaultRunLoopMode 默认模式 (非滚动状态)
     *   NSRunLoopCommonModes 几个模式的集合, 它里面就包含了 ("默认模式" 和 "滚动模式")
     *   下面代码代表无论在哪种模式下, timer都要工作
     */
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  在绘图之前调用, 这里的视图的布局已经完成了
 *  所以, 有了这个方法, 就不用再外部setImg之前, 用[self layoutIfNeeded]
 *  在绘图之前把 跳到中间去
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:wheelCount / 2];
    /**
     *   滚动某个单元格到 collectionView
     *   参数1: 传入需要滚动的单元格索引
     *   参数2: 把这个单元格滚动到屏幕的哪个位置 (传入 0, 因为屏幕只显示一个 cell)
     *   参数3: 需不需要动画效果
     */
    [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

// 当 WheelView 被销毁时, 也必须把 NSTimer 销毁
- (void)removeFromSuperview {
    [super removeFromSuperview];
    // 销毁计时器
    [_timer invalidate];
}

// 自动翻页
- (void)nextPage {
    if (!self.window) return;
    NSIndexPath *index = [self.collectionView indexPathsForVisibleItems].firstObject;
    NSInteger section = index.section;
    NSInteger item;
    // 根据方向 判断滚动到哪个 item
    if (_FX == FY_Direction_Top || _FX == FY_Direction_Left) {
        item = index.item + 1;
        if (index.item == _imgs.count - 1) {
            section ++;
            item = 0;
        }
    } else {
        item = index.item - 1;
        if (index.item == 0) {
            section --;
            item = _imgs.count - 1;
        }
    }
    NSIndexPath *newIndex = [NSIndexPath indexPathForItem:item inSection:section];
    // 用代码的方式来滚动并且带了动画效果, 它不会触发减速完成的代理方法
    [self.collectionView scrollToItemAtIndexPath:newIndex atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

@end
