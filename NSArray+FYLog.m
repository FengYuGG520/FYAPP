#import <Foundation/Foundation.h>

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
