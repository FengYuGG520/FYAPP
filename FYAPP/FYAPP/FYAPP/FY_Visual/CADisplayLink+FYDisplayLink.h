#import <QuartzCore/QuartzCore.h>

@interface CADisplayLink (FYDisplayLink)

/**
 刷帧时钟 参数1: 谁来做事 参数2: 做什么事 参数3: 每秒做多少次这件事

 @param target 谁来做事
 @param action 做什么事
 @param HZ 每秒做多少次这件事
 @return CADisplayLink 对象
 */
+ (instancetype)fy_target:(id)target action:(SEL)action HZ:(int)HZ;

@end
