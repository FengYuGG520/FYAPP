#import "FYConstraintMaker.h"
#import "FYViewConstraint.h"
#import "FYCompositeConstraint.h"
#import "FYConstraint+Private.h"
#import "FYViewAttribute.h"
#import "View+FYAdditions.h"

@interface FYConstraintMaker () <FYConstraintDelegate>

@property (weak, nonatomic) FY_VIEW *view;
@property (strong, nonatomic) NSMutableArray *constraints;

@end

@implementation FYConstraintMaker

- (id)initWithView:(FY_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [FYViewConstraint installedConstraintsForView:self.view];
        for (FYConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (FYConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

- (void)constraint:(FYConstraint *)constraint shouldBeReplacedWithConstraint:(FYConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (FYConstraint *)constraint:(FYConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    FYViewAttribute *viewAttribute = [[FYViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    FYViewConstraint *newConstraint = [[FYViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:FYViewConstraint.class]) {
        
        NSArray *children = @[constraint, newConstraint];
        FYCompositeConstraint *compositeConstraint = [[FYCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (FYConstraint *)addConstraintWithAttributes:(FYAttribute)attrs {
    __unused FYAttribute anyAttribute = (FYAttributeLeft | FYAttributeRight | FYAttributeTop | FYAttributeBottom | FYAttributeLeading
                                          | FYAttributeTrailing | FYAttributeWidth | FYAttributeHeight | FYAttributeCenterX
                                         | FYAttributeCenterY | FYAttributeBaseline
                                         
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | FYAttributeFirstBaseline | FYAttributeLastBaseline
#endif
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
                                          | FYAttributeLeftMargin | FYAttributeRightMargin | FYAttributeTopMargin | FYAttributeBottomMargin
                                          | FYAttributeLeadingMargin | FYAttributeTrailingMargin | FYAttributeCenterXWithinMargins
                                          | FYAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & FYAttributeLeft) [attributes addObject:self.view.fy_left];
    if (attrs & FYAttributeRight) [attributes addObject:self.view.fy_right];
    if (attrs & FYAttributeTop) [attributes addObject:self.view.fy_top];
    if (attrs & FYAttributeBottom) [attributes addObject:self.view.fy_bottom];
    if (attrs & FYAttributeLeading) [attributes addObject:self.view.fy_leading];
    if (attrs & FYAttributeTrailing) [attributes addObject:self.view.fy_trailing];
    if (attrs & FYAttributeWidth) [attributes addObject:self.view.fy_width];
    if (attrs & FYAttributeHeight) [attributes addObject:self.view.fy_height];
    if (attrs & FYAttributeCenterX) [attributes addObject:self.view.fy_centerX];
    if (attrs & FYAttributeCenterY) [attributes addObject:self.view.fy_centerY];
    if (attrs & FYAttributeBaseline) [attributes addObject:self.view.fy_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & FYAttributeFirstBaseline) [attributes addObject:self.view.fy_firstBaseline];
    if (attrs & FYAttributeLastBaseline) [attributes addObject:self.view.fy_lastBaseline];
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    if (attrs & FYAttributeLeftMargin) [attributes addObject:self.view.fy_leftMargin];
    if (attrs & FYAttributeRightMargin) [attributes addObject:self.view.fy_rightMargin];
    if (attrs & FYAttributeTopMargin) [attributes addObject:self.view.fy_topMargin];
    if (attrs & FYAttributeBottomMargin) [attributes addObject:self.view.fy_bottomMargin];
    if (attrs & FYAttributeLeadingMargin) [attributes addObject:self.view.fy_leadingMargin];
    if (attrs & FYAttributeTrailingMargin) [attributes addObject:self.view.fy_trailingMargin];
    if (attrs & FYAttributeCenterXWithinMargins) [attributes addObject:self.view.fy_centerXWithinMargins];
    if (attrs & FYAttributeCenterYWithinMargins) [attributes addObject:self.view.fy_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (FYViewAttribute *a in attributes) {
        [children addObject:[[FYViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    FYCompositeConstraint *constraint = [[FYCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

- (FYConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
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

- (FYConstraint *(^)(FYAttribute))attributes {
    return ^(FYAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
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

- (FYConstraint *)edges {
    return [self addConstraintWithAttributes:FYAttributeTop | FYAttributeLeft | FYAttributeRight | FYAttributeBottom];
}

- (FYConstraint *)size {
    return [self addConstraintWithAttributes:FYAttributeWidth | FYAttributeHeight];
}

- (FYConstraint *)center {
    return [self addConstraintWithAttributes:FYAttributeCenterX | FYAttributeCenterY];
}

- (FYConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();
        
        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        FYCompositeConstraint *constraint = [[FYCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
