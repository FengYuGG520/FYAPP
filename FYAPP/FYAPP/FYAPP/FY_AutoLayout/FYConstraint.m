#import "FYConstraint.h"
#import "FYConstraint+Private.h"

#define FYMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation FYConstraint

- (id)init {
    NSAssert(![self isMemberOfClass:[FYConstraint class]], @"FYConstraint is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (FYConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (FYConstraint * (^)(id))fy_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (FYConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (FYConstraint * (^)(id))fy_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (FYConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (FYConstraint * (^)(id))fy_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (FYConstraint * (^)())priorityLow {
    return ^id{
        self.priority(FYLayoutPriorityDefaultLow);
        return self;
    };
}

- (FYConstraint * (^)())priorityMedium {
    return ^id{
        self.priority(FYLayoutPriorityDefaultMedium);
        return self;
    };
}

- (FYConstraint * (^)())priorityHigh {
    return ^id{
        self.priority(FYLayoutPriorityDefaultHigh);
        return self;
    };
}

- (FYConstraint * (^)(FYEdgeInsets))insets {
    return ^id(FYEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (FYConstraint * (^)(CGFloat))inset {
    return ^id(CGFloat inset){
        self.inset = inset;
        return self;
    };
}

- (FYConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (FYConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (FYConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (FYConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

- (FYConstraint * (^)(id offset))fy_offset {
    
    return nil;
}

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(FYEdgeInsets)) == 0) {
        FYEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

- (FYConstraint *)with {
    return self;
}

- (FYConstraint *)and {
    return self;
}

- (FYConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    FYMethodNotImplemented();
}

- (FYConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (FYConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (FYConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (FYConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (FYConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (FYConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (FYConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (FYConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (FYConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (FYConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (FYConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (FYConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (FYConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (FYConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (FYConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (FYConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (FYConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (FYConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (FYConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (FYConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (FYConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

- (FYConstraint * (^)(CGFloat multiplier))multipliedBy { FYMethodNotImplemented(); }

- (FYConstraint * (^)(CGFloat divider))dividedBy { FYMethodNotImplemented(); }

- (FYConstraint * (^)(FYLayoutPriority priority))priority { FYMethodNotImplemented(); }

- (FYConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { FYMethodNotImplemented(); }

- (FYConstraint * (^)(id key))key { FYMethodNotImplemented(); }

- (void)setInsets:(FYEdgeInsets __unused)insets { FYMethodNotImplemented(); }

- (void)setInset:(CGFloat __unused)inset { FYMethodNotImplemented(); }

- (void)setSizeOffset:(CGSize __unused)sizeOffset { FYMethodNotImplemented(); }

- (void)setCenterOffset:(CGPoint __unused)centerOffset { FYMethodNotImplemented(); }

- (void)setOffset:(CGFloat __unused)offset { FYMethodNotImplemented(); }

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (FYConstraint *)animator { FYMethodNotImplemented(); }

#endif

- (void)activate { FYMethodNotImplemented(); }

- (void)deactivate { FYMethodNotImplemented(); }

- (void)install { FYMethodNotImplemented(); }

- (void)uninstall { FYMethodNotImplemented(); }

@end
