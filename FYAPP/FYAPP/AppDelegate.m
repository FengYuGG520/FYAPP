#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

// 此方法只会在程序启动时调用一次
// 如果此方法再调用一次, 证明这是重新打开的程序
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"程序加载完毕");
    
    self.window = [UIWindow new];
    
    [self.window makeKeyAndVisible];
    
#if defined(DEBUG) || defined(_DEBUG)
    // 这个方法必须在 makeKeyAndVisible 后面调用才能看见.
    [FYTools fy_fpsShow];
#endif
    
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    return YES;
}

- (void)openURL {
    UIApplication *application = [UIApplication sharedApplication];
    // 让你的菊花转起来
    application.networkActivityIndicatorVisible = YES;
    // 打开网页
    [application openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    // 打电话, 模拟器演示不了
    [application openURL:[NSURL URLWithString:@"tel://10086"]];
    [application openURL:[NSURL URLWithString:@"sms://10086"]];
}

- (void)notification {
    // iOS10 之前用这个
    UIApplication *application = [UIApplication sharedApplication];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    // #import <UserNotifications/UserNotifications.h>
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
            // 参数1: 如果点的是同意, 那么 granted 的值为 YES, 如果点的不同意, 值为 NO
            // 参数2: 如果运行中出错, 那么就返回 error 这个错误对象
            NSLog(@"当用户点完同意或者拒绝后会来执行这个block  %d", granted);
            // 判断用户是否开启通知, 如果没有开启, 则提示用户某些功能不能用让它去设置里开启
        }];
    }
}

// 应用程序即将关闭时调用的方法
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序即将退出");
    
    [self saveContext];
}

// 当程序即将失去焦点时会调用的方法: 当前屏幕并不是完整显示 app 的一种状态
// 可以在这里让当前的进度暂停, 例如游戏暂停
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"失去焦点了");
}

// 当程序完全进入到后台以后会调用的方法
// 可以在这里保存数据
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"进入到后台了");
}

// 当程序即将进入前台会调用的方法(点击 app 图标的那一刻)
// 先已经在后台, 然后再回来时才调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"即将进入前台");
}

// 已经获取焦点时调用
// 代表当前界面可以开始用户交互了(铺满屏幕那一刻)
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"已经取得焦点");
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FYAPP"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
