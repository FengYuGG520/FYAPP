#import "UIImage+FYImage.h"

@implementation UIImage (FYImage)

- (instancetype)fy_showOverviewT:(CGFloat)top L:(CGFloat)left B:(CGFloat)bottom R:(CGFloat)right {
    // 调用该图片的这个方法, 通过设置平铺的四个方向的距离, 0.0~1.0 得到该图片平铺后的图片
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height * top, self.size.width * left, self.size.height * bottom, self.size.width * right) resizingMode:UIImageResizingModeTile];
}

+ (instancetype)fy_originalImgNamed:(NSString *)name {
    // 把该图片名的渲染效果去掉, 并返回
    // (案例: 去掉 TabBar 图片的渲染效果, 显示源生图片的样子)
    return [[self imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)fy_imgURL:(NSURL *)url {
    // 根据 URL 路径返回图片
    return [self imageWithData:[NSData dataWithContentsOfURL:url]];
}

@end
