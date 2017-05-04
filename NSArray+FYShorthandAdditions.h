#import "NSArray+FYAdditions.h"

#ifdef FY_SHORTHAND

@interface NSArray (FYShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(FYConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(FYConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(FYConstraintMaker *make))block;

@end

@implementation NSArray (FYShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(FYConstraintMaker *))block {
    return [self fy_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(FYConstraintMaker *))block {
    return [self fy_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(FYConstraintMaker *))block {
    return [self fy_remakeConstraints:block];
}

@end

#endif
