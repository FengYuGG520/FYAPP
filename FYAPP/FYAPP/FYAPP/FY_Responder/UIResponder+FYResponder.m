//
//  UIResponder+FYResponder.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "UIResponder+FYResponder.h"

@implementation UIResponder (FYResponder)

- (instancetype)fy_nextResponder {
    return self.nextResponder;
}

@end
