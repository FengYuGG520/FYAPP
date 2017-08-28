#import "FYCoverFlowView.h"
#import "FYAutoLayout.h"
#import "UIView+FYView.h"
#import "UICollectionView+FYCollectionView.h"
#import "UICollectionViewFlowLayout+FYCollectionViewFlowLayout.h"

// 设置图片相对于父视图的宽度比
#define ScaleWidth 0.4
// 设置图片相对于父视图的高度比
#define ScaleHeight 1
// 设置左侧右侧图片相对于中间图片缩放比
#define ScaleCenter 0.9

@interface FYCoverFlowViewCell : UICollectionViewCell

// 图片模型
@property (strong, nonatomic) UIImage *model;
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation FYCoverFlowViewCell

- (void)setModel:(UIImage *)model {
    _model = model;
    _imageView.image = model;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *iv = [UIImageView new];
    iv.frame = self.contentView.bounds;
    // 设置图片填充样式为填充
    
    [iv fy_imgStyle];
    // 设置边框颜色和宽度
    [iv fy_borderColor:[UIColor colorWithWhite:0.9 alpha:0.1] borderWidth:2.0];
    // 圆角效果
    [iv fy_radius:4];
    // 添加到 contentView 并记录
    [self.contentView addSubview:iv];
    self.imageView = iv;
}

@end

@interface FYCoverFlowViewLayout : UICollectionViewFlowLayout

@end

// 宏定义 collectionView 的宽度, 方便取值
#define collectionViewWidth self.collectionView.bounds.size.width

@implementation FYCoverFlowViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    // 设置 cell 的大小
    CGFloat itemW = self.collectionView.bounds.size.width * ScaleWidth;
    CGFloat itemH = self.collectionView.bounds.size.height * ScaleHeight;
    // 设置内边距, 保证最后一个和最前面一个能正常显示
    CGFloat margin = (self.collectionView.bounds.size.width - itemW) * 0.5;
    [self fy_layoutLineSpace:0 itemSpace:0 itemSize:CGSizeMake(itemW, itemH) groupSpace:UIEdgeInsetsMake(0, margin, 0, margin) scrollHorizontal:YES];
}

// 在滚动的时候是否实时重新计算他们的布局
// 为 YES 才行, 为 NO 代表不会实时计算, 默认为 NO
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 *  这个方法就是根据 prepareLayout 里写的数据, 自动计算出每个cell的布局信息 (坐标, 大小)
 *  参数 rect 的含义: 你传入一个矩形框范围, 它会计算出这个范围内所有显示的 cell 的布局信息
 *  特点: 并不会每次滚动都来调用这个计算
 *  我们就在这个方法里面做一些特殊布局
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 记录 collectionView 的宽度
    NSArray<UICollectionViewLayoutAttributes *> *attArr = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray<UICollectionViewLayoutAttributes *> *arrM = [NSMutableArray new];
    // 遍历每个 item 的布局信息
    [attArr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 拷贝布局信息
        UICollectionViewLayoutAttributes *newArr = obj.copy;
        // 修改布局信息
        // 确定 collectionView 中间的 X
        CGFloat cvCenterX = self.collectionView.contentOffset.x + collectionViewWidth * 0.5;
        // 计算 cell 中心点的 X 坐标
        CGFloat cellCenterX = newArr.center.x;
        // 计算出这个距离的差
        CGFloat distance = cvCenterX - cellCenterX;
        // 根据距离差计算缩放比例
        CGFloat scale = 1 - ABS(distance) / (collectionViewWidth * ScaleCenter);
        // 获取四阶单位矩阵, 是单位矩阵, 该矩阵没有缩放 旋转 歪斜 透视, 该矩阵应用到图层上, 就是设置默认值
        CATransform3D transform3D = CATransform3DIdentity;
        // 设置缩放
        transform3D = CATransform3DScale(transform3D, scale, scale, 1);
        // 根据距离差计算旋转比例
        CGFloat angle = distance / collectionViewWidth * M_PI_2;
        // 设置旋转
        transform3D.m34 = -1.0 / 600;
        transform3D = CATransform3DRotate(transform3D, angle, 0, 1, 0);
        // 赋值 3D 旋转效果
        newArr.transform3D = transform3D;
        [arrM addObject:newArr];
    }];
    // 返回布局信息
    return arrM.copy;
}

/**
 *  下面这个方法会在手指滑动之后, 根据力度计算出最终偏移值
 *  参数1: 将要停留的位置
 *  参数2: 速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 先拿到计算好的偏移量
    CGPoint p = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    // 拿到将来停留位置的显示区域
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, collectionViewWidth, self.collectionView.bounds.size.height);
    // 获取停留位置内显示的所有 cell 对应的布局信息
    NSArray<UICollectionViewLayoutAttributes *> *attArr = [self layoutAttributesForElementsInRect:rect];
    // 找出其中距离中线最近的 cell
    // 记录最小的距离对应的布局信息
    __block CGFloat minNum = CGFLOAT_MAX;   // 无穷大
    __block UICollectionViewLayoutAttributes *att;
    // 确定中线的 x
    CGFloat cvCenterX = proposedContentOffset.x + collectionViewWidth * 0.5;
    [attArr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 确定布局信息的 center 的 X
        CGFloat cellCenterX = obj.center.x;
        // 比较找出最近布局信息, 计算距离
        CGFloat distance = cvCenterX - cellCenterX;
        // 比较
        if (ABS(distance) < minNum) {
            minNum = ABS(distance);
            att = obj;
        }
    }];
    // 确定偏移量, 进行修改
    CGFloat offsetX = att.center.x - cvCenterX;
    return CGPointMake(p.x + offsetX, p.y);
}

@end

@interface FYCoverFlowView () <UICollectionViewDataSource>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) BOOL repeat;

@end

static NSString *coverFlowViewCell = @"coverFlowViewCell";

@implementation FYCoverFlowView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupUI];
}

- (void)setupUI {
    FYCoverFlowViewLayout *layout = [FYCoverFlowViewLayout new];
    UICollectionView *cv = [UICollectionView fy_collectionLayout:layout target:self itemName:@"FYCoverFlowViewCell" itemID:coverFlowViewCell];
    // 禁用预读功能
    [cv fy_collectionPrefetchNO];
    cv.backgroundColor = [UIColor clearColor];
    [self addSubview:cv];
    [cv fy_makeConstraints:^(FYConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.collectionView = cv;
}

// 返回行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _models.count;
}

// 返回 item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FYCoverFlowViewCell *cell = (FYCoverFlowViewCell *)[collectionView fy_collectionItemID:coverFlowViewCell indexPath:indexPath];
    NSInteger index = indexPath.item % self.models.count;
    cell.model = self.models[index];
    return cell;
}

@end
