#import "FYCompositeConstraint.h"
#import "FYConstraint+Private.h"

@interface FYCompositeConstraint () <FYConstraintDelegate>

@property (strong, nonatomic) id fy_key;
@property (strong, nonatomic) NSMutableArray *childConstraints;

@end

@implementation FYCompositeConstraint

- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;
    
    _childConstraints = [children mutableCopy];
    for (FYConstraint *constraint in _childConstraints) {
        constraint.delegate = self;
    }
    
    return self;
}

- (void)constraint:(FYConstraint *)constraint shouldBeReplacedWithConstraint:(FYConstraint *)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (FYConstraint *)constraint:(FYConstraint __unused *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id<FYConstraintDelegate> strongDelegate = self.delegate;
    FYConstraint *newConstraint = [strongDelegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    newConstraint.delegate = self;
    [self.childConstraints addObject:newConstraint];
    return newConstraint;
}

- (FYConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (FYConstraint *constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (FYConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (FYConstraint *constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}

- (FYConstraint * (^)(FYLayoutPriority))priority {
    return ^id(FYLayoutPriority priority) {
        for (FYConstraint *constraint in self.childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

- (FYConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (FYConstraint *constraint in self.childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}

- (FYConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    return self;
}

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (FYConstraint *)animator {
    for (FYConstraint *constraint in self.childConstraints) {
        [constraint animator];
    }
    return self;
}

#endif

- (FYConstraint * (^)(id))key {
    return ^id(id key) {
        self.fy_key = key;
        int i = 0;
        for (FYConstraint *constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}

- (void)setInsets:(FYEdgeInsets)insets {
    for (FYConstraint *constraint in self.childConstraints) {
        constraint.insets = insets;
    }
}

- (void)setInset:(CGFloat)inset {
    for (FYConstraint *constraint in self.childConstraints) {
        constraint.inset = inset;
    }
}

- (void)setOffset:(CGFloat)offset {
    for (FYConstraint *constraint in self.childConstraints) {
        constraint.offset = offset;
    }
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    for (FYConstraint *constraint in self.childConstraints) {
        constraint.sizeOffset = sizeOffset;
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    for (FYConstraint *constraint in self.childConstraints) {
        constraint.centerOffset = centerOffset;
    }
}

- (void)activate {
    for (FYConstraint *constraint in self.childConstraints) {
        [constraint activate];
    }
}

- (void)deactivate {
    for (FYConstraint *constraint in self.childConstraints) {
        [constraint deactivate];
    }
}

- (void)install {
    for (FYConstraint *constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (FYConstraint *constraint in self.childConstraints) {
        [constraint uninstall];
    }
}

@end
