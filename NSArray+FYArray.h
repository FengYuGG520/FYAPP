#import <Foundation/Foundation.h>

@interface NSArray (FYArray)

/**
 根据 plist 文件全名, 以及模型名, 得到这个模型数组

 @param plistName plist 文件全名
 @param modelName 模型名
 @return 得到这个模型数组
 */
+ (NSArray *)fy_plistName:(NSString *)plistName modelName:(NSString *)modelName;

@end

@interface NSObject (FYArray)

/**
 使用字典创建模型对象
 
 @param dic 字典
 @return 模型对象
 */
+ (instancetype)fy_objWithDic:(NSDictionary *)dic;

@end
