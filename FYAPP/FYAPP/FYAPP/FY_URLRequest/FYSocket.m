#import "FYSocket.h"
#import "FYGCD.h"
#import <sys/socket.h>// socket
#import <arpa/inet.h>// struct sockaddr_in

@implementation FYSocket

+ (void)fy_socketGET:(NSString *)urlStr complete:(void (^)(NSString *allResponse, NSString *response, int error))complete {
    [FYGCD fy_gcdQueue:[FYGCD fy_gcdQueue:FY_Queue_Concurrent] task:FY_Task_Async block:^{
        NSString *get = [urlStr substringFromIndex:NSMaxRange([urlStr rangeOfString:@"//"])];
        NSString *host = [get substringToIndex:NSMaxRange([get rangeOfString:@"/"])];
        host = [host substringWithRange:NSMakeRange(0, host.length - 1)];
        get = [get substringWithRange:NSMakeRange(host.length, get.length - host.length)];
        // MARK: 1. 创建 socket
        /**
         *  1: 协议族
         *      AF_INET  /- UDP, TCP -/ (决定了要用 ipv4 地址与16位端口号的组合)
         *      AF_INET6 /- IPv6 -/
         *  2: 指定 socket 类型
         *      SOCK_STREAM /- 面向连接的, 和 TCP 协议配套 -/
         *      SOCK_DGRAM  /- 无连接的, 和 UDP 协议配套 -/
         *  3: 指定协议 (如果此参数为0, 则会根据参数2自动设定本参数)
         *      IPPROTO_TCP /- TCP 传输协议 -/
         *      IPPROTO_UDP /- UDP 传输协议 -/
         */
        int soc = socket(AF_INET, SOCK_STREAM, 0);
        // MARK: 2. 建立连接
        /**
         *  1: socket
         *  2: 指向数据结构 sockaddr 的指针, 其中包括目的端口和 IP 地址
         *  3: 参数2的长度
         */
        struct sockaddr_in addr;
        addr.sin_family = AF_INET;// 决定了要用 ipv4 地址和16位端口号的组合
        addr.sin_port = htons(80);// 端口号
        addr.sin_addr.s_addr = inet_addr(host.UTF8String);// IP 地址
        int conn = connect(soc, (const struct sockaddr *)&addr, sizeof(addr));
        // MARK: 3. 发送数据
        /**
         *  1: socket
         *  2: 指明存放要发送数据的缓冲区
         *  3: 指明实际要发送数据的字符个数
         *  4: 一般给0 (是否阻塞, 是否等待)
         */
        const char *sendC = [NSString stringWithFormat:@"GET %@ HTTP/1.1\r\nHost: %@\r\n\r\n", get, host].UTF8String;
        send(soc, sendC, strlen(sendC), 0);
        // MARK: 4. 接收数据
        /**
         *  1: socket
         *  2: 接收到的字节数组
         *  3: 参数2的大小
         *  4: 默认给0 (是否阻塞)
         */
        unsigned char chs[1024];
        long len = recv(soc, chs, sizeof(chs), 0);
        // 字节转换成字符串
        NSData *data = [NSData dataWithBytes:chs length:len];
        NSString *allRespon = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 如何去掉响应头? (根据响应头后面会接 \r\n\r\n)
        NSString *respon = [allRespon substringFromIndex:NSMaxRange([allRespon rangeOfString:@"\r\n\r\n"])];
        // 调用主队列执行
        [FYGCD fy_gcdMainAsync:^{
            complete(allRespon, respon, conn);
        }];
        // 关闭连接
        close(soc);
    }];
}

@end
