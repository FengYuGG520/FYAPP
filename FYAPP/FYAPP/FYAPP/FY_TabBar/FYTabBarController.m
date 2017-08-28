#import "FYTabBarController.h"
#import "NSArray+FYArray.h"
#import "UIViewController+FYViewController.h"
#import "UINavigationController+FYNavigationController.h"
#import "UITabBarController+FYTabBarController.h"

/**
 *  模型 Key (plist 里面的 key, 必须是这四个)
 */
@interface FYTabBarControllerModel : NSObject

// tabBarItem 的标题
@property (copy, nonatomic) NSString *title;
// 控制器类名
@property (copy, nonatomic) NSString *viewController;
// 默认 tabBarItem 图片名
@property (copy, nonatomic) NSString *norImg;
// 选中 tabBarItem 图片名
@property (copy, nonatomic) NSString *selImg;

@end

@implementation FYTabBarControllerModel

@end

@interface FYTabBarController ()

// 模型数组
@property (strong, nonatomic) NSArray<FYTabBarControllerModel *> *models;

@end

@implementation FYTabBarController

// 类方法创建
+ (instancetype)fy_tabBarPlistName:(NSString *)plist {
    return [[self alloc] initWithPlist:plist];
}

// 高潮 (不建议使用)
+ (instancetype)FY {
    return [FYTabBarController fy_tabBarPlistName:@"FYTabBar"];
}

- (instancetype)initWithPlist:(NSString *)plist {
    if (self = [super init]) {
        // 根据 plist 文件名, 拿到模型
        _models = [NSArray fy_plistName:plist modelName:@"FYTabBarControllerModel"];
        // 添加控制器, 并给每个控制器设置导航控制器
        [self addControllers];
        /**
         *  创建 TabBar 的准备
         *      1. 去掉 TabBar 透明效果
         *      2. 设置 TabBar 选中时字体颜色为红色
         */
        [self fy_tabTrans];
        [self fy_tabSelTxtColor:[UIColor redColor]];
    }
    return self;
}

// 添加控制器, 并给每个控制器设置导航控制器
- (void)addControllers {
    NSUInteger count = self.models.count;
    NSMutableArray *arrM = [NSMutableArray new];
    for (int i = 0; i< count; i++) {
        // 根据模型名, 添加每个 nav 控制器
        FYTabBarControllerModel *model = self.models[i];
        [arrM addObject:[self fy_clsName:model.viewController title:model.title norImgName:model.norImg selImgName:model.selImg]];
    }
    self.viewControllers = arrM.copy;
}

// 得到 nav 控制器
- (UINavigationController *)fy_clsName:(NSString *)clsName title:(NSString *)title norImgName:(NSString *)norImgName selImgName:(NSString *)selImgName {
    // 根据类名拿到控制器
    Class c = NSClassFromString(clsName);
    UIViewController *vc = [c new];
    if (!vc) vc = [UIViewController new];
    // 设置每个 tabBarItem 标题 默认图片 选中图片
    [vc fy_tabBarTitle:title norImg:norImgName selImg:selImgName];
    // 给每个控制器设置一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    /**
     *  创建导航控制器的准备
     *      1. 去掉导航栏下面的分割线
     *      2. 去掉导航条半透明效果
     *      3. 设置导航栏其他文字为灰色
     *      4. 设置导航条标题文字为黑色
     *      5. 设置导航条颜色为白色
     */
    [nav fy_navLine];
    [nav fy_navTrans];
    [nav fy_navItemTxtColor:[UIColor grayColor]];
    [nav fy_navTitleTxtColor:[UIColor blackColor]];
    [nav fy_navTitleBackColor:[UIColor whiteColor]];
    return nav;
}

@end
