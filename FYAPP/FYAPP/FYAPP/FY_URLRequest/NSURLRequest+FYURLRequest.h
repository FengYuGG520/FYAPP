#import <UIKit/UIKit.h>
#import "FY_Enum.h"

@interface NSURLRequest (FYURLRequest)

/**
 GET 请求 参数1: url 或 urlStr 参数2: 完成后处理的代码块 (在子线程)

 @param url url 或 urlStr
 @param complete 完成后处理的代码块
 */
+ (void)fy_GET:(id)url complete:(void (^)(NSData *data, NSURLResponse *response, NSError *error))complete;

/**
 POST 请求 参数1: url 或 urlStr 参数2: 请求体的二进制数据 参数3: 请求体的数据类型 参数4: 完成后处理的代码块 (在子线程)

 @param url url 或 urlStr
 @param data 请求体的二进制数据
 @param FY_Data_Enum 请求体的数据类型
 @param complete 完成后处理的代码块
 */
+ (void)fy_POST:(id)url bodyData:(NSData *)data bodyType:(FY_Data)FY_Data_Enum complete:(void (^)(NSData *data, NSURLResponse *response, NSError *error))complete;

@end
