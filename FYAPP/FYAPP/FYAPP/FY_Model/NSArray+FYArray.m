#import "NSArray+FYArray.h"
#import "NSObject+FYArray.h"
#import "UIImage+FYImage.h"

@implementation NSArray (FYArray)

+ (NSArray *)fy_plistName:(NSString *)plistName modelName:(NSString *)modelName {
    // 加载本地 plist 文件
    NSMutableString *strM = [NSMutableString stringWithString:plistName];
    [strM appendString:@".plist"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:strM withExtension:nil];
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *arrM = [NSMutableArray new];
    // 根据字符串拿到模型类的 class
    Class model = NSClassFromString(modelName);
    for (NSDictionary *dic in arr) [arrM addObject:[model fy_objWithDic:dic]];
    return arrM.copy;
}

+ (NSArray<UIImage *> *)fy_ImgArrWithURLArr:(NSArray<NSURL *> *)urls {
    NSMutableArray *arrM = [NSMutableArray new];
    // 根据URL数组一个一个的转换为图片
    for (int i = 0; i < urls.count; i++) [arrM addObject:[UIImage fy_imgURL:urls[i]]];
    return arrM.copy;
}

- (void)fy_arrMoveRow:(NSInteger)moveRow toRow:(NSInteger)toRow {
    id model = self[moveRow];
    [(NSMutableArray *)self removeObjectAtIndex:moveRow];
    [(NSMutableArray *)self insertObject:model atIndex:toRow];
}

- (void)fy_arrmAddArr:(NSArray *)arr {
    [(NSMutableArray *)self addObjectsFromArray:arr];
}

@end

/**
 *  MARK: 规范打印数组
 */
@implementation NSArray (FYLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"@[\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@"]"];
    NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [strM deleteCharactersInRange:range];
    }
    return strM;
}

@end

/**
 *  MARK: 规范打印字典
 */
@implementation NSDictionary (FYLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"@{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@:%@,\n", key, obj];
    }];
    [strM appendString:@"}"];
    NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [strM deleteCharactersInRange:range];
    }
    return strM;
}

@end
