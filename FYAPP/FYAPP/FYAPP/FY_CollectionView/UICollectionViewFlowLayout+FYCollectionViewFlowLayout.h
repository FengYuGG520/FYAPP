//
//  UICollectionViewFlowLayout+FYCollectionViewFlowLayout.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewFlowLayout (FYCollectionViewFlowLayout)

/**
 布局 参数1: 行间距 参数2: 单元格间距 参数3: itemSize 参数4: 每组 的间距 (上, 左, 下, 右) 参数5: 是否水平滚动, 默认为垂直滚动
 
 @param lineSpace 行间距
 @param itemSpace 单元格间距
 @param itemSize itemSize
 @param groupSpace 每组 的间距 (上, 左, 下, 右)
 @param horizontal 是否水平滚动, 默认为垂直滚动
 */
- (void)fy_layoutLineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace itemSize:(CGSize)itemSize groupSpace:(UIEdgeInsets)groupSpace scrollHorizontal:(BOOL)horizontal;

/**
 设置组头组尾的大小, 是否悬停
 
 @param headerSize 组头大小
 @param footerSize 组尾大小
 @param headerHover 组头悬停
 @param footerHover 组尾悬停
 */
- (void)fy_layoutHeaderSize:(CGSize)headerSize footerSize:(CGSize)footerSize headerHover:(BOOL)headerHover footerHover:(BOOL)footerHover;

@end
