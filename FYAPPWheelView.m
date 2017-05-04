#import "FYAPPWheelView.h"
#import "FYAPPWheelViewLayout.h"
#import "FYAPPWheelViewCell.h"
#import "FYAutoLayout.h"

/*
    定义组
 */
#define wheelCount 5

static NSString *wheelCell = @"wheelCell";

@interface FYAPPWheelView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation FYAPPWheelView

/*
    代码创建
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

/*
    从 XIB 中创建
 */
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setImgs:(NSArray<NSURL *> *)imgs {
    
    _imgs = imgs;
    
    _pageControl.numberOfPages = imgs.count;
    
    /*
        刷新 collectionView
     */
    [_collectionView reloadData];
    
    /*
        数据加载完毕后, 自动滚动到中间那组第 0 张
        创建第 0 个索引
     */
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:wheelCount / 2];
    
    /*
        滚动某个单元格到 collectionView
        参数1: 传入需要滚动的单元格索引
        参数2: 把这个单元格滚动到屏幕的哪个位置 (传入 0, 因为屏幕只显示一个 cell)
        参数3: 需不需要动画效果
     */
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    /*
        参数1: 多久触发一次 (单位 秒)
        参数2: 哪个对象来处理
        参数3: 触发事件时, 来调用哪个方法
        参数4: 给处理事件的方法的参数, 这里传 nil
        参数5: 是否重复, 为 YES 则一直重复, 为 NO 则只执行一次
     */
    _timer = [NSTimer timerWithTimeInterval:FYWheelHZ target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    /*
        需要把 timer 添加到消息循环里才有用
        NSDefaultRunLoopMode 默认模式 (非滚动状态)
        NSRunLoopCommonModes 几个模式的集合, 它里面就包含了 ("默认模式" 和 "滚动模式")
        下面代码代表无论在哪种模式下, timer都要工作
     */
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/*
    当 WheelView 被销毁时, 也必须把 NSTimer 销毁
 */
- (void)removeFromSuperview {
    
    [super removeFromSuperview];
    
    /*
        销毁 NSTimer 对象
     */
    [_timer invalidate];
}

/*
    自动翻页
 */
- (void)nextPage {
    
    /*
        如果当前视图 window 属性为 nil, 则代表屏幕上显示的视图并不是当前视图
        如果已经是显示别的视图了, 那么直接 return, 后面的计时器代码不会执行
     */
    if (!self.window) return;
    
    /*
        获取当前显示的 cell 的 indexPath
     */
    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    
    /*
        先取出当前显示 cell 所在的 section
     */
    NSInteger section = indexPath.section;
    
    NSInteger item;
    
    if (FYWheelFX == 1 || FYWheelFX == 3) {
        
        item = indexPath.item + 1;
        if (indexPath.item == _imgs.count - 1) {
            
            section ++;
            item = 0;
        }
    } else {
        
        item = indexPath.item - 1;
        if (indexPath.item == 0) {
            
            section --;
            item = _imgs.count - 1;
        }
    }
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    /*
        用代码的方式来滚动并且带了动画效果, 它不会触发减速完成的代理方法
     */
    [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupUI {
    
    /*
        先创建 UICollectionView 的布局对象
     */
    FYAPPWheelViewLayout *layout = [FYAPPWheelViewLayout new];
    
    /*
        创建 UICollectionView
     */
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    /*
        注册 cell
     */
    [cv registerClass:[FYAPPWheelViewCell class] forCellWithReuseIdentifier:wheelCell];
    
    /*
        开启分页
        禁用弹簧效果
        禁用滚动条
     */
    cv.pagingEnabled = YES;
    cv.bounces = NO;
    cv.showsHorizontalScrollIndicator = NO;
    cv.showsVerticalScrollIndicator = NO;
    
    /*
        设置 数据源
        设置 代理
     */
    cv.dataSource = self;
    cv.delegate = self;
    
    [self addSubview:cv];
    
    /*
        布局并记录
     */
    [cv fy_makeConstraints:^(FYConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
    _collectionView = cv;
    _pageControl = nil;
    
    if (FYOpenPage) {
    
        /*
            分页指示器
         */
        UIPageControl *pg = [UIPageControl new];
        
        pg.pageIndicatorTintColor = [UIColor orangeColor];
        pg.currentPageIndicatorTintColor = [UIColor redColor];
        
        [self addSubview:pg];
        
        /*
            设置分页指示器 的 位置
         */
        [pg fy_makeConstraints:^(FYConstraintMaker *make) {
            
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.fy_bottom);
        }];
        
        _pageControl = pg;
    }
}

#pragma mark - 代理方法
/*
    开始拖动
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    /*
        停止计时器工作
     */
    _timer.fireDate = [NSDate distantFuture];
}

/*
    结束拖拽
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    /*
        开启计时器工作
     */
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:FYWheelHZ * 1.5];
}

/*
    滚动完成
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    /*
        获取到当前屏幕上可见的 cell 所对应的索引, 返回的是一个数组? (因为屏幕上可能会有多个 cell 在显示, 但是我们当前这个程序因为 cell 和 collectionView 一样大, 所以你可见区域永远只有一个 cell, 所以直接取 firstObject)
     */
    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].firstObject;
    
    /*
        如果是第 0 组或者最后一组, 那么则需要滚到中间那组去
        因为只要不是第 0 组或者最后一组, 它既可以往左边滚, 也可以往右边滚, 我们只需要处理两端的那组就行 (第 0 组和最后一组)
     */
    if (indexPath.section == 0 || indexPath.section == wheelCount - 1) {
        
        /*
            偷偷把这个 cell 替换为 中间那组相同索引的 cell, 因为每组相同索引的 cell 内容都一样
         */
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForItem:indexPath.item inSection:wheelCount / 2];
        
        /*
            不给动画效果
         */
        [self.collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

/*
    用动画方式滚动完成
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
}

/*
    分页指示器的滚动方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = 0;
    
    if (FYWheelFX == 1 || FYWheelFX == 2) {
        
        page = (int)(scrollView.contentOffset.y / _collectionView.bounds.size.height + 0.5) % wheelCount;
    } else {
        
        page = (int)(scrollView.contentOffset.x / _collectionView.bounds.size.width + 0.5) % wheelCount;
    }
    
    _pageControl.currentPage = page;
}

#pragma mark - 数据源方法
/*
    返回组
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return wheelCount;
}

/*
    返回单元格个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _imgs.count;
}

/*
    返回单元格
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FYAPPWheelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:wheelCell forIndexPath:indexPath];
    
    cell.img = _imgs[indexPath.item];
    
    return cell;
}

@end
