#import "UIViewController+FYViewController.h"
#import "UIImage+FYImage.h"

@implementation UIViewController (FYViewController)

- (void)fy_addController:(UIViewController *)controller viewTo:(UIView *)view {
    // 1. 调用容器控制器的 addChildViewController 的方法, 把其他控制器传过来
    [self addChildViewController:controller];
    // 2. 把其他控制器的根视图作为容器控制器的根视图里的子视图
    [view addSubview:controller.view];
    // 3. 设置其他控制器的根视图大小 (可以省略, 省略的话就跟容器控制器的根视图一样大)
    // 4. 调用其他控制器的 didMoveToParentViewController 方法
    [controller didMoveToParentViewController:self];
}

- (void)fy_navRTitle:(NSString *)RTitle action:(SEL)action BTitle:(NSString *)BTitle navTitle:(NSString *)navTitle {
    // 设置该控制器的导航条右边 ButtonItem 的文本, 以及点击事件
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RTitle style:UIBarButtonItemStylePlain target:self action:action];
    /**
     *  设置返回该控制器的那个按钮的文本, 这个返回事件添加不了
     *  只能在 push 进栈的那个控制器的 leftBarButtonItem 里添加
     */
    if (BTitle) self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:BTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    if (navTitle) self.navigationItem.title = navTitle;// 设置导航栏的文本
}

- (void)fy_tabBarTitle:(NSString *)title norImg:(NSString *)norImg selImg:(NSString *)selImg {
    if (title) self.tabBarItem.title = title;// 设置 TabBar 文本
    if (norImg) self.tabBarItem.image = [UIImage imageNamed:norImg];// 默认图片
    if (selImg) self.tabBarItem.selectedImage = [UIImage fy_originalImgNamed:selImg];// 选中图片
}

- (void)fy_navCut {
    // 隐藏控制器上面的导航条, 记得要在这个控制器 viewWillDisappear (即将消失的时候), 再把导航条显示出来
    self.navigationController.navigationBar.hidden = YES;
}

- (void)fy_tabCut {
    self.hidesBottomBarWhenPushed = YES;// 去掉控制器底部的TabBar
}

- (void)fy_touchMore {
    self.view.multipleTouchEnabled = YES;// 接收多个手指触摸事件 (默认只接收一个点击事件)
}

- (void)fy_pushVC:(UIViewController *)VC animated:(BOOL)animated {
    if (!self.tabBarController) [self.navigationController pushViewController:VC animated:animated];
    else [self.tabBarController.navigationController pushViewController:VC animated:animated];
}

- (UIViewController *)fy_popVCAnimated:(BOOL)animated {
    if (!self.tabBarController) return [self.navigationController popViewControllerAnimated:animated];
    else return [self.tabBarController.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToVC:(UIViewController *)VC animated:(BOOL)animated {
    if (!self.tabBarController) return [self.navigationController popToViewController:VC animated:YES];
    else return [self.tabBarController.navigationController popToViewController:VC animated:YES];
}

+ (instancetype)fy_vcInSB:(NSString *)sb ID:(NSString *)ID {
    // 如果 ID 为 nil 则返回 sb 里面带箭头的那个控制器
    if (!ID) return [[UIViewController fy_sbName:sb] instantiateInitialViewController];
    // 拿到 sb 中对应 ID 的控制器
    return [[UIViewController fy_sbName:sb] instantiateViewControllerWithIdentifier:ID];
}

+ (UIStoryboard *)fy_sbName:(NSString *)sbName {
    // 返回当前 bundle 里面对应名字的 UIStoryboard
    return [UIStoryboard storyboardWithName:sbName bundle:nil];
}

@end
