//
//  UserModel.h
//  FYAPP
//
//  Created by shang on 2017/9/14.
//  Copyright © 2017年 FengYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataModel.h"

@interface UserModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) UserDataModel *data;

@end
