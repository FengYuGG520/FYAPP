#import <UIKit/UIKit.h>
// 控制器里面的控件参数的属性必须用 week, 防止控件 removeFromSuperview 移除后, 还有控制器引用着

/**
 *  往导航栏右边添加多个 item
 *  self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem, self.editButtonItem];
 */
@interface UIViewControllerDoc : NSObject
@end
@implementation UIViewControllerDoc
// 控制器状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }
// 隐藏控制器状态栏
- (BOOL)prefersStatusBarHidden { return YES; }
@end


/**
 *  MARK: - 创建控制器的三种方式
 *  (1). 纯代码
 *  (2). sb 中根据 ID 加载
 *  (3). xib 加载
 *
 *  MARK: - 通过加载 xib 文件来描述控制器的 View, 直接 new 系统执行步骤
 *  FYViewController *vc = [ViewController new];
 *  (1). - (void)loadView;
 *  系统会先去 FYViewController 的这个类里面找有没有重写这个方法, 如果有重写, 直接加载这个类的 view
 *  (2). FYViewController.xib
 *  如果没有, 去 3
 *  (3). FYView.xib
 *  如果没有, 创建类文件里的纯净的 view
 *  (2) (3) 使用步骤:
 *  要想 xib 文件能描述控制器的 view, 必须要做的两步
 *  (1). 选中 xib 文件, 点击 File's Owner, 绑定类名
 *  (2). 右击 File's Owner, 选中 view 属性, 拖线到 xib (请忽略感叹号)
 *
 *  MARK: - 根据 nib 文件加载视图
 *  FYViewController *vc = [nib instantiateWithOwner:nil options:nil].firstObject;
 *  走 awakeFromNib 方法
 */
