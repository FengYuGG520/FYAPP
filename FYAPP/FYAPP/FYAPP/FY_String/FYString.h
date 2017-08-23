//
//  FYString.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYString : NSString

/**
 把字符串变成 url
 
 @return url
 */
- (NSURL *)fy_urlStr;

/**
 给一个本地路径的字符串前面加上 file:// 多用于下载文件指定的本地目录
 
 @return 本地路径 (沙盒)
 */
- (NSURL *)fy_urlFile;

/**
 根据文件路径的字符串, 返回该文件的文件名
 
 @return 该文件的文件名
 */
- (instancetype)fy_fileName;

/**
 根据文件的路径, 拿到这个文件的内容字符串
 
 @return 这个文件对应路径内容的字符串
 */
- (instancetype)fy_pathContent;

@end
