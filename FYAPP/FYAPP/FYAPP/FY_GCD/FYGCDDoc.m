#import <UIKit/UIKit.h>
#import "FYGCD.h"
@interface FYGCDDoc : UIViewController
// 经过本人亲手测试, 在主线线程调用主队列执行同步任务会造成线程死锁, 在主线程调用主队列执行异步任务就会等主线程忙完了在执行那个任务, 在子线程调用主队列执行同步任务就和没写一样, 在子线程调用主队列执行异步任务就会等主线程忙完了在执行那个任务
@end
@implementation FYGCDDoc
/**
 *   GCD会自动利用更多的CPU内核 (比如双核、四核)
 *   GCD会自动管理线程的生命周期 (创建线程、调度任务、销毁线程)
 *   程序员只需要告诉GCD想要执行什么任务, 不需要编写任何线程管理代码
 *
 *   GCD 和 NSThread 相比
 *   它不必每次创建异步任务都要开启一个新的线程, 它会把执行完的任务放到线程缓存池, 所以减少了 CPU 的消耗
 *   而 NSThread 每次执行, 都会重新开启一个新的线程
 *   GCD 可以线程重用, 可以把一些异步操作放在同一个子线程里
 *
 *   串行队列
 *       dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
 *   主队列 (只有等主线程空闲的时候调用) (特殊的串行队列)
 *       dispatch_queue_t queue = dispatch_get_main_queue();
 *   并行队列 (开发第三方框架的时候, 建议用)
 *       dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
 *   全局队列 (日常开发中, 建议用) (就是并发队列)
 *       dispatch_queue_t queue = dispatch_get_global_queue(0, 0);// DISPATCH_QUEUE_PRIORITY_HIGH 第一个参数是优先级
 *
 *   同步任务
 *       dispatch_sync(dispatch_queue_t queue, dispatch_block_t block);
 *   异步任务
 *       dispatch_async(dispatch_queue_t queue, dispatch_block_t block);
 *   障碍任务
 *       dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t block);
 *   延迟任务
 *       dispatch_after(time, dispatch_queue_t, dispatch_block_t block);
 *   一次任务
 *       static dispatch_once_t onceDispatch;
 *       dispatch_once(&onceDispatch, dispatch_block_t block);
 *
 *   调度组 (调度组中的所有异步任务执行结束之后, 会得到统一的通知)
 *       dispatch_group_async(dispatch_group_t group, dispatch_queue_t queue, dispatch_block_t block);
 *
 */

// MARK: -> GCD 同步案列
- (void)demo1 {
    // 创建一个串行队列
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Serial];
    // 异步添加数据到数组
    [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
        for (int i = 0; i < 10; i ++) {
            NSLog(@"添加数组");
        }
    }];
    // 同步读取数组
    [FYGCD fy_gcdQueue:queue task:FY_Task_Sync block:^{
        NSLog(@"读取数组");
    }];
}
// MARK: 异步串行, 如果把队列放到循环里, 那就相当于创建了多个串行队列, 会出现多个线程
- (void)demo2 {
    NSLog(@"start %@", [NSThread currentThread]);
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Serial];
    for (int i = 0; i < 10; i ++) {
        [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
            NSLog(@"%@", [NSThread currentThread]);// 都是 <number = 3>
        }];
    }
}
// MARK: 并发同步队列
- (void)demo3 {
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Concurrent];
    [FYGCD fy_gcdQueue:queue task:FY_Task_Sync block:^{
        NSLog(@"%@", [NSThread currentThread]);// 没有开启线程 <number = 1, name = main>
    }];
}
// MARK: 主队列 + 同步任务 = 死锁
- (void)demo4 {
    // 1. 执行顺序: @"start" 后面的任务被阻塞
    // 2. 同步任务和主线程相互等待, 造成线程死锁
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Main];
    NSLog(@"start");
    [FYGCD fy_gcdQueue:queue task:FY_Task_Sync block:^{
        NSLog(@"就是不出来 %@", [NSThread currentThread]);
    }];
    NSLog(@"end");
    // 死锁解决办法 -> 把这个同步任务放到子线程中
}
// MARK: 障碍任务
- (void)demo5 {
    // 作用: 在并行队列中, 等待前面两个操作完成, 然后执行下面的操作
    // 用途: 当大量线程访问一个线程不安全的时候, 可以使用
    // 创建一个并发队列
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Concurrent];
    [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
        NSLog(@"dispatch-1");
    }];
    [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
        NSLog(@"dispatch-2");
    }];
    // 等待并行操作完成, 这里是指并行输出 dispatch-1 dispatch-2
    // 然后执行 dispatch-barrier
    // 最后队列恢复原有的执行状态, 继续执行 dispatch-3 dispatch-4
    [FYGCD fy_gcdQueue:queue task:FY_Task_Barrier block:^{
        NSLog(@"dispatch-barrier");
    }];
    [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
        NSLog(@"dispatch-3");
    }];
    [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
        NSLog(@"dispatch-4");
    }];
}
// MARK: 延迟任务
- (void)demo6 {
    /*
     *   延迟任务 (也是个异步任务, 不过在主队列, 就在主线程执行, 全局或并发队列, 就开启新的线程)
     *   里面的参数, 表示的是在运行到这行代码的当前时间的几秒后, 加入把任务加入到对应的队列
     */
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Main];
    [FYGCD fy_gcdQueue:queue afterTime:3.0 block:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
}
// MARK: 一次任务
- (void)demo7 {
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Global];
    for (int i = 0; i < 10; i ++) {
        [FYGCD fy_gcdQueue:queue task:FY_Task_Async block:^{
            
            // 一次任务
            [FYGCD fy_gcdQueue:queue task:FY_Task_Once block:^{
                NSLog(@"我特么就执行一次 %@", [NSThread currentThread]);
            }];
            
        }];
    }
}
// MARK: 调度组
- (void)demo8 {
    // 创建一个调度组
    fy_gcd_group group = [FYGCD fy_gcdGroup];
    // 创建一个并发队列
    fy_gcd_queue queue = [FYGCD fy_gcdQueue:FY_Queue_Concurrent];
    // 将任务添加到队列和调度组
    [FYGCD fy_gcdAddQueue:queue toGroup:group block:^{
        NSLog(@"下载 A %@", [NSThread currentThread]);
    }];
    [FYGCD fy_gcdAddQueue:queue toGroup:group block:^{
        NSLog(@"下载 B %@", [NSThread currentThread]);
    }];
    [FYGCD fy_gcdAddQueue:queue toGroup:group block:^{
        NSLog(@"下载 C %@", [NSThread currentThread]);
    }];
    // 调度组中的所有异步任务执行结束后, 在这里得到统一的通知
    [FYGCD fy_gcdNotiGroup:group queue:[FYGCD fy_gcdQueue:FY_Queue_Main] block:^{
        NSLog(@"下载全部完成 %@", [NSThread currentThread]);
    }];
}

@end
