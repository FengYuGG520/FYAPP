//
//  NSURL+FYURL.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "NSURL+FYURL.h"

@implementation NSURL (FYURL)

+ (NSURL *)fy_URLNibName:(NSString *)nibName {
    return [[NSBundle mainBundle] URLForResource:nibName withExtension:@"nib"];
}

+ (NSString *)fy_readURL:(NSURL *)url {
    // 读取 URL 路径的文件, 用字符串接收, 并返回
    return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)fy_writeStr:(NSString *)string toURL:(NSURL *)url {
    // 把字符串写入一个 URL 路径里, 如果写入成功, 则返回 YES
    return [string writeToURL:url atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

+ (instancetype)fy_URLGETInStr:(NSString *)str {
    return [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

+ (NSString *)fy_filePath:(NSString *)str {
    return [[NSBundle mainBundle] pathForResource:str ofType:nil];
}

@end
