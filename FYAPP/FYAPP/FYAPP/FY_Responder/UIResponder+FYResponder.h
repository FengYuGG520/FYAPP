//
//  UIResponder+FYResponder.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (FYResponder)

/**
 返回这个视图的父视图

 @return 这个视图的父视图
 */
- (instancetype)fy_nextResponder;

@end
