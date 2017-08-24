#import "UITableViewCell+FYTableViewCell.h"

@implementation UITableViewCell (FYTableViewCell)

- (void)fy_cellArrows {
    /**
     *  cell 右边的配件
     *  UITableViewCellAccessoryNone                    无
     *  UITableViewCellAccessoryDisclosureIndicator     >
     *  UITableViewCellAccessoryDetailDisclosureButton  !>
     *  UITableViewCellAccessoryCheckmark               √
     *  UITableViewCellAccessoryDetailButton            !
     */
    // 给 cell 右边设置一个箭头
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
