// 1. 创建并设置样式
// 2. 注册 cell 标识
// 3. 设置代理, 遵守协议, 布局并记录
// 4. 数据源拿到 cell

#import <UIKit/UIKit.h>

@interface UITableView (FYTableView)

/**
 tableView 参数1: 样式 参数2: 代理或数据源 参数3: 类名或 xib 名 参数4: cellID 参数5: 自动行高

 @param group 初始化并设置样式
 @param target 设置代理, 以及数据源对象
 @param cellName 类名或 xib 名
 @param cellID cellID
 @param heightAuto 设置自动行高
 @return tableView
 */
+ (instancetype)fy_tableGroup:(BOOL)group target:(id)target cellName:(NSString *)cellName cellID:(NSString *)cellID heightAuto:(BOOL)heightAuto;

/**
 根据类名或 xib 名, 注册 cellID

 @param cellName 类名或 xib 名
 @param cellID cellID
 */
- (void)fy_tableCellName:(NSString *)cellName cellID:(NSString *)cellID;

/**
 在 tableView 的数据源方法里面, 拿到 cell

 @param cellID cellID
 @param indexPath indexPath
 @return (UITableViewCell *)
 */
- (id)fy_tableCellID:(NSString *)cellID indexPath:(NSIndexPath *)indexPath;

/**
 去掉 cell 分割线
 */
- (void)fy_tableCutSeparator;

/**
 重新加载数据
 */
- (void)fy_tableReload;

/**
 滚动到某个 cell, 参数1: indexPath 参数2: 定位 参数3: 是否动画

 @param indexPath indexPath
 @param position 定位
 @param animated 是否动画
 */
- (void)fy_tableToIndexPath:(NSIndexPath *)indexPath position:(UITableViewScrollPosition)position animated:(BOOL)animated;

/**
 滚动到最近的在选择状态的 cell, 参数1: 定位 参数2: 是否动画

 @param position 定位
 @param animated 是否动画
 */
- (void)fy_tableToSelectedPosition:(UITableViewScrollPosition)position animated:(BOOL)animated;

@end
