#import "FYModel.h"
#import "NSObject+FYArray.h"

@implementation FYModel

- (void)setValue:(id)value forKey:(NSString *)key {
    // 保持原有设置
    [super setValue:value forKey:key];
    // 处理 desc
    if ([key isEqualToString:@"description"]) [super setValue:value forKey:@"desc"];
}

/**
 *  当用 KVC 方式赋值, 找不到属性时, 就会调用这个方法来尝试解决
 *  我们重写这个方法, 但是千万别调用 super
 *  这样, 就可以在 KVC 赋值不成功时, 程序既不崩溃
 *  也可以根据哪个 key 来重新给 key 赋值, 比如 description (系统关键字) 改成 desc
 *  参数1: 需要给这个 key 赋的值
 *  参数2: 找不到的那个 key
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    NSLog(@"<%@>这个模型类中没有定义<%@>这个属性", [self class], key);
}

+ (NSArray *)fy_plistName:(NSString *)plistName {
    // 加载本地 plist 文件
    NSMutableString *strM = [NSMutableString stringWithString:plistName];
    [strM appendString:@".plist"];
    NSArray *arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:strM withExtension:nil]];
    NSMutableArray *arrM = [NSMutableArray new];
    for (NSDictionary *dic in arr) [arrM addObject:[self fy_objWithDic:dic]];
    return arrM.copy;
}

@end
