#import <UIKit/UIKit.h>

/**
 *  手势密码视图使用方式:
 *  1. 类方法创建, 传入密码
 *  2. 传入 plist 文件名
 *  3. 文件名格式必须为一个数组, 数组里面有一个字典
 *      norImg : 默认图片名
 *      highImg : 高亮图片名
 *      errImg : 错误图片名
 */
@interface FYAPPGestureLockView : UIView

/**
 类方法创建, 传入密码字符串 (1~9) 和 plist 文件名

 @param pwd 解锁密码
 @param plistName plist 文件名
 @return 手势解锁视图
 */
+ (instancetype)fy_Pwd:(NSString *)pwd plistName:(NSString *)plistName;

@end
