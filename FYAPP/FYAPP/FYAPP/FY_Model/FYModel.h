#import <Foundation/Foundation.h>
#import "NSObject+FYModel.h"

@interface FYModel : NSObject

// 因为父类有了这个属性, 所有子类继承的时候, 如果重写这个属性就会报错
@property (strong, nonatomic) NSString *desc;

/**
 根据 plist 文件名得到这个类或其子类的模型数组

 @param plistName plist 文件名
 @return 这个类或其子类的模型数组
 */
+ (NSArray *)fy_plistName:(NSString *)plistName;

@end
