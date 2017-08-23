//
//  FYNetworking.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FYNetworking : AFHTTPSessionManager

/**
 *  网络请求工具类全局访问点
 *
 *  @return AFHTTPSessionManager的实例
 */
+ (instancetype)sharedNetworkTool;

/**
 *  网络请求工具类GET请求的主方法
 *
 *  @param URLString 请求地址
 *  @param parameters 请求参数
 *  @param success   成功的回调
 *  @param faile     失败的回调
 */
- (void)fy_GETURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile;

/**
 *  网络请求工具类POST请求的主方法
 *
 *  @param URLString 请求地址
 *  @param parameters 请求参数
 *  @param success   成功的回调
 *  @param faile     失败的回调
 */
- (void)fy_POSTURLString:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile;

@end

/**
 *  1: 向服务器发送 postJSON 的时候
 *      需设 manager.requestSerializer = [AFJSONRequestSerializer new];
 *  2: 向服务器发送 https 请求时, 需设
 *          manager.responseSerializer = [AFHTTPResponseSerializer new];
 *          manager.securityPolicy.allowInvalidCertificates = YES;// 允许使用不合法的证书发起请求
 *          manager.securityPolicy.validatesDomainName = NO;// 不验证域名 (网址) 的有效性
 *  3: 默认情况下, AFN 请求默认接收的数据类型有 application/json text/json text/javascript
 *          manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
 *  4: XML 的解析: manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
 *     DOM 的解析: manager.responseSerializer = [AFHTTPResponseSerializer new];
 *  5: 文件上传 & 文件下载
 */
