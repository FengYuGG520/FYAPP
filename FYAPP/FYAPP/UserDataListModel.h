//
//  UserDataListModel.h
//  FYAPP
//
//  Created by shang on 2017/9/14.
//  Copyright © 2017年 FengYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataListModel : NSObject

@property (nonatomic, assign) int prodId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) int price;
@property (nonatomic, copy) NSString *salePrice;

@end
