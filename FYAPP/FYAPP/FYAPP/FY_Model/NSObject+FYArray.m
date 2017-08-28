#import "NSObject+FYArray.h"

@implementation NSObject (FYArray)

+ (instancetype)fy_objWithDic:(NSDictionary *)dic {
    id obj = [self new];
    [obj setValuesForKeysWithDictionary:dic];
    return obj;
}

@end
