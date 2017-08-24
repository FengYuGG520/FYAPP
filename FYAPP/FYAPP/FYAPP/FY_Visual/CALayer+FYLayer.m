/**
 *  任何东西要显示, 必须有 CALayer, 所有的 UIView 能显示就是因为它有 layer
 *  既然 layer 就能显示, 为什么还要有 UIView
 *  因为 UIView 可以响应事件
 *  UIView 本身不负责显示, 它只负责响应事件, layer 才是真正显示内容
 *
 *  CALayer *layer = [CALayer layer];
 *  // 下面两句话效果一样
 *  layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"1"].CGImage);
 *  layer.contents = CFBridgingRelease(([UIImage imageNamed:@"1"].CGImage));
 *  // 设置 layer 的位置 大小 背景色
 *  layer.position = self.view.center;
 *  layer.bounds = CGRectMake(0, 0, 100, 100);
 *  layer.backgroundColor = [UIColor orangeColor].CGColor;
 *  // 阴影 (要想阴影有效果, 就不能有 masksToBounds=YES)
 *  // 如果给宽度, 那么阴影往左右移动, 如果给高度, 那么久往上下移动
 *  layer.shadowOffset = CGSizeMake(20, 20);
 *  layer.shadowColor = [UIColor redColor].CGColor;
 *  // 设置高斯模糊半径 (毛玻璃效果)
 *  layer.shadowRadius = 50;
 *  // layer 透明度
 *  layer.opacity = YES;
 *  // layer 要显示, 必须添加父 layer 里
 *  [self.view.layer addSublayer:layer];
 */

#import "CALayer+FYLayer.h"

@implementation CALayer (FYLayer)

- (void)start3D {
    CATransform3D tran = self.transform;
    /**
     *  先设置 layer 的透视效果 (远小近大)
     *  设置范围 (500~1000), 越小透视效果越明显
     */
    tran.m34 = -1.0 / 600;
    self.transform = tran;
}

@end

/**
 *  m11（x缩放）, m12（y切变）, m13（旋转）, m14（）;
 *  m21（x切变）, m22（y缩放）, m23（）, m24（）;
 *  m31（旋转）, m32（）, m33（）, m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
 *  m41（x平移）, m42（y平移）, m43（z平移）, m44（）;
 */
