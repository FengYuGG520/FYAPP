#import "View+FYAdditions.h"
#import <objc/runtime.h>

@implementation FY_VIEW (FYAdditions)

- (NSArray *)fy_makeConstraints:(void(^)(FYConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    FYConstraintMaker *constraintMaker = [[FYConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)fy_updateConstraints:(void(^)(FYConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    FYConstraintMaker *constraintMaker = [[FYConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)fy_remakeConstraints:(void(^)(FYConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    FYConstraintMaker *constraintMaker = [[FYConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (FYViewAttribute *)fy_left {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (FYViewAttribute *)fy_top {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (FYViewAttribute *)fy_right {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (FYViewAttribute *)fy_bottom {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (FYViewAttribute *)fy_leading {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (FYViewAttribute *)fy_trailing {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (FYViewAttribute *)fy_width {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (FYViewAttribute *)fy_height {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (FYViewAttribute *)fy_centerX {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (FYViewAttribute *)fy_centerY {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (FYViewAttribute *)fy_baseline {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (FYViewAttribute *(^)(NSLayoutAttribute))fy_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[FYViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (FYViewAttribute *)fy_firstBaseline {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (FYViewAttribute *)fy_lastBaseline {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (FYViewAttribute *)fy_leftMargin {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (FYViewAttribute *)fy_rightMargin {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (FYViewAttribute *)fy_topMargin {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (FYViewAttribute *)fy_bottomMargin {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (FYViewAttribute *)fy_leadingMargin {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (FYViewAttribute *)fy_trailingMargin {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (FYViewAttribute *)fy_centerXWithinMargins {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (FYViewAttribute *)fy_centerYWithinMargins {
    return [[FYViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

- (id)fy_key {
    return objc_getAssociatedObject(self, @selector(fy_key));
}

- (void)setFy_key:(id)key {
    objc_setAssociatedObject(self, @selector(fy_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (instancetype)fy_closestCommonSuperview:(FY_VIEW *)view {
    FY_VIEW *closestCommonSuperview = nil;
    
    FY_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        FY_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
