//
//  FYString.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "FYString.h"

@implementation FYString

- (NSURL *)fy_urlStr {
    return [NSURL URLWithString:self];
}

- (NSURL *)fy_urlFile {
    return [NSURL fileURLWithPath:self];
}

- (instancetype)fy_fileName {
    return [self lastPathComponent];
}

- (instancetype)fy_pathContent {
    return [NSString stringWithContentsOfFile:self encoding:NSUTF8StringEncoding error:NULL];
}

@end
