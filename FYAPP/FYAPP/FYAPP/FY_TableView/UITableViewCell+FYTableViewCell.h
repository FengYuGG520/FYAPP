// 1. tableViewCell 的构造方法只能是 - (instancetype)initWithStyle: reuseIdentifier:
// 2. 每点击一次 cell, 都会触发 cell 的 layoutSubviews 方法

#import <UIKit/UIKit.h>

@interface UITableViewCell (FYTableViewCell)

/**
 给 cell 右边设置一个箭头
 */
- (void)fy_cellArrows;

@end
