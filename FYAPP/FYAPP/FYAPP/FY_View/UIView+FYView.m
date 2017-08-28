#import "UIView+FYView.h"

@implementation UIView (FYView)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w {
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)w {
    return self.frame.size.width;
}

- (CGFloat)h {
    return self.frame.size.height;
}

- (void)setH:(CGFloat)h {
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

+ (instancetype)fy_viewXibName:(NSString *)xibName {
    return [[UINib nibWithNibName:xibName bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

+ (instancetype)fy_viewXib {
    return [self fy_viewXibName:NSStringFromClass(self)];
}

- (UIImage *)fy_snapshootImg {
    /**
     *  开启当前视图大小的图片的图形上下文
     *  参数1: 图形上下文中大小
     *  参数2: 是否不透明 YES 不透明 NO 透明
     *  参数3: 屏幕的缩放因子, 普通屏幕=1 retina=2 plus=3 系统匹配=0
     */
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    // 将视图的内容绘制到上下文中 Hierarchy 层次结构
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    // 从当前图片的上下文获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 得到图片后, 若想写入相册, 则执行下面代码
    /**
     *  把此图片写入相册
     *  参数1: 图片对象
     *  参数2, 3: 代表保存完成后调用哪个对象的哪个方法
     *  参数4: 传入的是什么, 那么保存完毕调用的方法里第三个参数就是什么
     */
    // UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    return img;
}

- (void)fy_insertBottom:(UIView *)insert subview:(UIView *)subview {
    // 当前调用的视图为父视图, 在其中插入 insert 这个视图, 并把它放在已有的子视图 subview 下面
    [self insertSubview:insert belowSubview:subview];
}

- (void)fy_insertTop:(UIView *)insert subview:(UIView *)subview {
    // 当前调用的视图为父视图, 在其中插入 insert 这个视图, 并把它放在已有的子视图 subview 上面
    [self insertSubview:insert aboveSubview:subview];
}

- (void)fy_insert:(UIView *)insert index:(int)index {
    // 当前调用的视图为父视图, 在其中插入 insert 这个视图, 并给定这个视图的层次等级
    [self insertSubview:insert atIndex:index];
}

- (id)fy_tag:(int)tag {
    // 根据一个 tag 的值, 找到对应视图并返回
    return [self viewWithTag:tag];
}

/**
 *  CGAffineTransformScale              在现有的基础上放大
 *  CGAffineTransformRotation           在现有的基础上旋转
 *  CGAffineTransformTranslation        在现有的基础上平移
 *
 *  CGAffineTransformMakeScale          在初始的状态下放大
 *  CGAffineTransformMakeRotation       在初始的状态下旋转
 *  CGAffineTransformMakeTranslation    在初始的状态下平移
 *
 *  CGAffineTransformIdentity           还原视图的 transform
 */
- (void)fy_animation {
    UILabel *lbl = nil;
    CGFloat time = 0.8;
    if (self.superview.subviews[1]) { lbl = (UILabel *)self.superview.subviews[1]; lbl.hidden = YES; }
    [UIView animateWithDuration:time animations:^{
        // 在现有的基础上放大 1.8倍
        self.transform = CGAffineTransformScale(self.transform, 1.8, 1.8);
        // 在现有的基础上旋转 半圈
        self.transform = CGAffineTransformRotate(self.transform, M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time animations:^{
            // 还原
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            lbl.hidden = NO;
            return ;
        }];
    }];
}

- (void)fy_imgStyle {
    /**
     *  UIViewContentModeScaleToFill        拉伸 (会变形)
     *  UIViewContentModeScaleAspectFit     平铺 (最佳)
     *  UIViewContentModeScaleAspectFill    居中 (图片小)
     */
    self.contentMode = UIViewContentModeScaleToFill;
}

- (void)fy_cutOverflow {
    // 实际上设置了父视图的属性, 让子视图的所有超过自己的部分不会显示
    self.superview.clipsToBounds = YES;
}

- (void)fy_borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    // 设置边框颜色
    self.layer.borderColor = borderColor.CGColor;
    // 设置边框宽度
    self.layer.borderWidth = borderWidth;
}

- (void)fy_radius:(CGFloat)radius {
    // 调用视图的 layer 的 maskaToBounds 把超过图层的部分去掉
    self.layer.masksToBounds = YES;
    // 设置视图图层的角落半径
    self.layer.cornerRadius = radius;
}

@end
