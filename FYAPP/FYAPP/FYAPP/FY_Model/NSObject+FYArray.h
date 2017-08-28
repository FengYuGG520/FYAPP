#import <Foundation/Foundation.h>

@interface NSObject (FYArray)

/**
 一个字典转换成一个模型
 
 @param dic 一个字典
 @return 一个模型
 */
+ (instancetype)fy_objWithDic:(NSDictionary *)dic;

@end
