#import "UITableView+FYTableView.h"
#import "UIView+FYView.h"
#import "NSURL+FYURL.h"

@implementation UITableView (FYTableView)

+ (instancetype)fy_tableGroup:(BOOL)group target:(id)target cellName:(NSString *)cellName cellID:(NSString *)cellID heightAuto:(BOOL)heightAuto {
    UITableView *tv = [self fy_tableGroup:group];
    [tv fy_tableTarget:target];
    [tv fy_tableCellName:cellName cellID:cellID];
    if (heightAuto) [tv fy_tableHeightAuto];
    return tv;
}

+ (instancetype)fy_tableGroup:(BOOL)group {
    return [[self alloc] initWithFrame:CGRectZero style:group ? UITableViewStyleGrouped : UITableViewStylePlain];
}

- (void)fy_tableCellName:(NSString *)cellName cellID:(NSString *)cellID {
    if ([NSURL fy_URLNibName:cellName]) {
        self.rowHeight = [UIView fy_viewXibName:cellName].bounds.size.height;
        [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellID];
    } else [self registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellID];
}

- (void)fy_tableTarget:(id)target {
    self.delegate = target;
    self.dataSource = target;
}

- (void)fy_tableHeightAuto {
    // 设置预估行高
    self.estimatedRowHeight = 20;
    // 设置自动行高
    self.rowHeight = UITableViewAutomaticDimension;
}

- (id)fy_tableCellID:(NSString *)cellID indexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
}

- (void)fy_tableCutSeparator {
    /**
     *  separatorColor                                  分割线颜色
     *  UITableViewCellSeparatorStyleNone               没有分割线
     *  UITableViewCellSeparatorStyleSingleLine         有一根线在cell下面 (默认值)
     *  UITableViewCellSeparatorStyleSingleLineEtched   有数据的没有分割线, 没有数据的有分割线
     */
    // 去掉 cell 分割线
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)fy_tableReload {
    [self reloadData];
}

- (void)fy_tableToIndexPath:(NSIndexPath *)indexPath position:(UITableViewScrollPosition)position animated:(BOOL)animated {
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:position animated:position];
}

- (void)fy_tableToSelectedPosition:(UITableViewScrollPosition)position animated:(BOOL)animated {
    [self scrollToNearestSelectedRowAtScrollPosition:position animated:animated];
}

//// 设置 cell 被选中时, 松手后黑色阴影消失
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 让选中的那行 cell 在点击后, 取消选中
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
// 或者在返回 cell 里面设置 cell.selectionStyle = UITableViewCellSelectionStyleNone;
// xib 也可以设置ß

@end
