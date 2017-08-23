//
//  UICollectionViewFlowLayout+FYCollectionViewFlowLayout.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "UICollectionViewFlowLayout+FYCollectionViewFlowLayout.h"

@implementation UICollectionViewFlowLayout (FYCollectionViewFlowLayout)

- (void)fy_layoutLineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace itemSize:(CGSize)itemSize groupSpace:(UIEdgeInsets)groupSpace scrollHorizontal:(BOOL)horizontal {
    self.minimumLineSpacing = lineSpace;// 行间距
    self.minimumInteritemSpacing = itemSpace;// 单元格间距
    self.itemSize = itemSize;
    self.sectionInset = groupSpace;// 每组 的间距 (上, 左, 下, 右)
    self.scrollDirection = horizontal ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
}

- (void)fy_layoutHeaderSize:(CGSize)headerSize footerSize:(CGSize)footerSize headerHover:(BOOL)headerHover footerHover:(BOOL)footerHover {
    // 设置 组头组尾大小
    self.headerReferenceSize = headerSize;
    self.footerReferenceSize = footerSize;
    // 设置 组头组尾是否悬停
    self.sectionHeadersPinToVisibleBounds = headerHover;
    self.sectionFootersPinToVisibleBounds = footerHover;
}

@end
