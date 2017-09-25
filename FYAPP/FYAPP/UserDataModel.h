//
//  UserDataModel.h
//  FYAPP
//
//  Created by shang on 2017/9/14.
//  Copyright © 2017年 FengYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataListModel.h"

@interface UserDataModel : NSObject

@property (nonatomic, copy) NSArray<UserDataListModel *> *list;

@end
