#import "CADisplayLink+FYDisplayLink.h"

@implementation CADisplayLink (FYDisplayLink)

+ (instancetype)fy_target:(id)target action:(SEL)action HZ:(int)HZ {
    // 刷帧时钟 参数1: 谁来做事 参数2: 做什么事
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:target selector:action];
    // 参数3: 每秒做多少次这件事
    link.preferredFramesPerSecond = HZ;
    // 把刷帧时钟加入到 NSRunLoopCommonModes 模式
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    return link;
}

@end
