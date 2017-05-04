#import "NSArray+FYArray.h"

@implementation NSArray (FYArray)

+ (NSArray *)fy_plistName:(NSString *)plistName modelName:(NSString *)modelName {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *arrM = [NSMutableArray new];
    Class model = NSClassFromString(modelName);
    for (NSDictionary *dic in arr) {
        
        [arrM addObject:[model fy_objWithDic:dic]];
    }
    
    return arrM.copy;
}

@end

@implementation NSObject (FYArray)

+ (instancetype)fy_objWithDic:(NSDictionary *)dic {
    
    id obj = [self new];
    [obj setValuesForKeysWithDictionary:dic];
    
    return obj;
}

@end
