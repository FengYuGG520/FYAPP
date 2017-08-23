//
//  FY_Define.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#ifndef FY_Define_h
#define FY_Define_h

#if DEBUG // 调试打印, 不影响发布
#define fyp(xx, ...) NSLog(xx, ##__VA_ARGS__)
#else
#define fyp(...)
#endif

#endif
