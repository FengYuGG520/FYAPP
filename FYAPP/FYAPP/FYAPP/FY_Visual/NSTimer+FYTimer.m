#import "NSTimer+FYTimer.h"

@implementation NSTimer (FYTimer)

+ (instancetype)fy_time:(double)time target:(id)target action:(SEL)action info:(id)info repeat:(BOOL)repeat {
    // 开启时钟做事情 参数1: 多久后做 参数2: 谁来做 参数3: 做什么 参数4: 附加信息 参数5: 是否重复做
    NSTimer *timer = [self timerWithTimeInterval:time target:target selector:action userInfo:info repeats:repeat];
    // 把计时器加入到 NSRunLoopCommonModes 模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

- (void)fy_endTime {
    // 当计时器暂停工作
    self.fireDate = [NSDate distantFuture];
}

- (void)fy_startTime:(double)time {
    // 在几秒后开启计时器工作
    self.fireDate = [NSDate dateWithTimeIntervalSinceNow:time];
}

@end
