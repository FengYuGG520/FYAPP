//
//  FYNetworking.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "FYNetworking.h"

@implementation FYNetworking

+ (instancetype)sharedNetworkTool{
    static FYNetworking *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 实例化Manager
        instance = [[self alloc]init];
        // 告知AFN让他给我返回原始的二进制数据(responseObject), 我自己反序列化
//        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 让AFN支持,客户端向服务器发送特殊的二进制, 比如 JSON plist
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        // 增加AFN支持的文件类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    
    return instance;
}

- (void)fy_GETURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile {
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN的回调, 默认就是在主线程
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
}

- (void)fy_POSTURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile {
    [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN的回调, 默认就是在主线程
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
}

@end
