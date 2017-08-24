#import <UIKit/UIKit.h>

@interface UIView (FYView)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

/**
 根据 xib 名得到它里面的视图

 @param xibName xib 名
 @return 视图
 */
+ (instancetype)fy_viewXibName:(NSString *)xibName;

/**
 得到当前对象的 xib 视图, 一定要 xib 名和视图类名一样才行 (极度暴力! 完全不讲道理啊!)

 @return 当前对象的 xib 视图
 */
+ (instancetype)fy_viewXib;

/**
 获得当前视图的截图图片
 
 @return 截图
 */
- (UIImage *)fy_snapshootImg;

/**
 这个父视图插入一个子视图, 在一个已有的子视图下面
 
 @param insert 插入的子视图
 @param subview 已有的子视图
 */
- (void)fy_insertBottom:(UIView *)insert subview:(UIView *)subview;

/**
 这个父视图插入一个子视图, 在一个已有的子视图上面
 
 @param insert 插入的子视图
 @param subview 已有的子视图
 */
- (void)fy_insertTop:(UIView *)insert subview:(UIView *)subview;

/**
 这个父视图插入一个子视图, 并设定层次等级
 
 @param insert 插入的子视图
 @param index 层次等级
 */
- (void)fy_insert:(UIView *)insert index:(int)index;

/**
 返回对应 tag 的视图
 
 @param tag tag
 @return 对应的视图
 */
- (id)fy_tag:(int)tag;

/**
 娱乐动画
 */
- (void)fy_animation;

/**
 设置 UIImageView 里面图片的填充样式 (用 imgView 调用)
 */
- (void)fy_imgStyle;

/**
 让本视图和兄弟视图超过父容器的部分隐藏掉
 */
- (void)fy_cutOverflow;

/**
 设置边框颜色和边框宽度
 
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)fy_borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 把视图的四个角修剪成圆弧
 
 @param radius 圆弧半径
 */
- (void)fy_radius:(CGFloat)radius;

@end
