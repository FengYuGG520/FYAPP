/**
 *   使用注意:
 *       1. 需要修改三个状态的星星图片
 *       2. new
 *       3. 设置 level
 *       4. 如果使用 XIB 记得在 XIB 中绑定这个类
 */

#import <UIKit/UIKit.h>

@interface FYAPPStarsView : UIView

/**
 星星的等级
 */
@property (assign, nonatomic) CGFloat level;

@end
