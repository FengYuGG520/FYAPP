#import "NSURLRequest+FYURLRequest.h"
#import "NSURL+FYURL.h"

@implementation NSURLRequest (FYURLRequest)

+ (void)fy_GET:(id)url complete:(void (^)(NSData *data, NSURLResponse *response, NSError *error))complete {
    if ([url isKindOfClass:[NSString class]]) url = [NSURL fy_URLGETInStr:url];
    [NSURLRequest fy_getURL:url complete:complete];
}

+ (void)fy_getURL:(NSURL *)url complete:(void (^)(NSData *data, NSURLResponse *response, NSError *error))complete {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:complete] resume];
}

+ (void)fy_POST:(id)url bodyData:(NSData *)data bodyType:(FY_Data)FY_Data_Enum complete:(void (^)(NSData *data, NSURLResponse *response, NSError *error))complete {
    if ([url isKindOfClass:[NSString class]]) url = [NSURL URLWithString:url];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];// 建立请求
    requestM.HTTPMethod = @"POST";// 手动指定请求方式
    requestM.HTTPBody = data;// 设置请求体 (也就是请求参数)
    if (FY_Data_Enum == FY_Data_Json) [requestM setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];// 选择向服务器发送数据的数据类型
    if (FY_Data_Enum == FY_Data_File) [requestM setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", FYHTTPBoundary] forHTTPHeaderField:@"Content-Type"];
    [NSURLRequest fy_postRequest:requestM complete:complete];
}

+ (void)fy_postRequest:(NSURLRequest *)request complete:(void (^)(NSData *data, NSURLResponse *response, NSError *error))complete {
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:complete] resume];
}

@end
