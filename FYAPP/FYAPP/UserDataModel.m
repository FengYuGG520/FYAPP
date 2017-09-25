//
//  UserDataModel.m
//  FYAPP
//
//  Created by shang on 2017/9/14.
//  Copyright © 2017年 FengYu. All rights reserved.
//

#import "UserDataModel.h"

@implementation UserDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : UserDataListModel.class};
}

@end
