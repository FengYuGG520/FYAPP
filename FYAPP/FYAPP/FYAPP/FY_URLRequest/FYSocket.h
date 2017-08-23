#import <UIKit/UIKit.h>

@interface FYSocket : NSObject

/**
 socket 的 http 1.1 的 get 请求
 GET 请求 参数1: urlStr 参数2: 完成后处理的代码块 (在主线程) (allResponse 包括响应头的字符串, response 不包括响应头的字符串, 需要的是 response)

 @param urlStr urlStr
 @param complete 完成后处理的代码块 (在主线程)
 */
+ (void)fy_socketGET:(NSString *)urlStr complete:(void (^)(NSString *allResponse, NSString *response, int error))complete;

@end
