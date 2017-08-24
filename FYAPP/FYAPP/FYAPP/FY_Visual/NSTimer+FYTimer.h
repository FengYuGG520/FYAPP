#import <Foundation/Foundation.h>

@interface NSTimer (FYTimer)

/**
 开启时钟做事情 参数1: 多久后做 参数2: 谁来做 参数3: 做什么 参数4: 附加信息 参数5: 是否重复做

 @param time 多久后做
 @param target 谁来做
 @param action 做什么
 @param info 附加信息
 @param repeat 是否重复做
 @return 时钟对象
 */
+ (instancetype)fy_time:(double)time target:(id)target action:(SEL)action info:(id)info repeat:(BOOL)repeat;

/**
 当计时器暂停工作
 */
- (void)fy_endTime;

/**
 当计时器在几秒后开始工作

 @param time 几秒后
 */
- (void)fy_startTime:(double)time;

@end
