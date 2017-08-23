//
//  NSURL+FYURL.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

/**
 *  本地  URL格式: @"file:///Users/sa/Desktop/abc.txt"
 *  网页  URL格式: @"http://www.baidu.com"
 *  ftp  URL格式: @"ftp://server.fengyu.cn/ios.txt"
 */
#import <Foundation/Foundation.h>

@interface NSURL (FYURL)

/**
 得到 xib 名的 URL 路径
 
 @param nibName xib 名
 @return URL 路径
 */
+ (NSURL *)fy_URLNibName:(NSString *)nibName;

/**
 读取 URL 路径的文件, 用字符串接收
 
 @param url URL 路径
 @return 字符串内容
 */
+ (NSString *)fy_readURL:(NSURL *)url;

/**
 把字符串写入一个 URL 路径里, 如果写入成功, 则返回 YES
 
 @param string 内容
 @param url URL 路径
 @return 是否写入成功
 */
+ (BOOL)fy_writeStr:(NSString *)string toURL:(NSURL *)url;

/**
 把一个 get 请求的全路径的字符串, 通过转义 (转换 ? 后面的汉字或空格) 后, 再转换为 url (只在 get 请求中会需要转义, post 请求不需要)
 
 @param str 一个 url 全路径的字符串
 @return url
 */
+ (instancetype)fy_URLGETInStr:(NSString *)str;

/**
 根据文件名, 得到这个文件在 mainBundle 里面的路径字符串
 
 @param str 文件名
 @return 这个文件在 mainBundle 里面的路径字符串
 */
+ (NSString *)fy_filePath:(NSString *)str;

@end
