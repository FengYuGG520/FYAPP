#import "FYUtilities.h"

@interface FYConstraint : NSObject

- (FYConstraint * (^)(FYEdgeInsets insets))insets;
- (FYConstraint * (^)(CGFloat inset))inset;
- (FYConstraint * (^)(CGSize offset))sizeOffset;
- (FYConstraint * (^)(CGPoint offset))centerOffset;
- (FYConstraint * (^)(CGFloat offset))offset;
- (FYConstraint * (^)(NSValue *value))valueOffset;
- (FYConstraint * (^)(CGFloat multiplier))multipliedBy;
- (FYConstraint * (^)(CGFloat divider))dividedBy;
- (FYConstraint * (^)(FYLayoutPriority priority))priority;
- (FYConstraint * (^)())priorityLow;
- (FYConstraint * (^)())priorityMedium;
- (FYConstraint * (^)())priorityHigh;
- (FYConstraint * (^)(id attr))equalTo;
- (FYConstraint * (^)(id attr))greaterThanOrEqualTo;
- (FYConstraint * (^)(id attr))lessThanOrEqualTo;
- (FYConstraint *)with;
- (FYConstraint *)and;
- (FYConstraint *)left;
- (FYConstraint *)top;
- (FYConstraint *)right;
- (FYConstraint *)bottom;
- (FYConstraint *)leading;
- (FYConstraint *)trailing;
- (FYConstraint *)width;
- (FYConstraint *)height;
- (FYConstraint *)centerX;
- (FYConstraint *)centerY;
- (FYConstraint *)baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (FYConstraint *)firstBaseline;
- (FYConstraint *)lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (FYConstraint *)leftMargin;
- (FYConstraint *)rightMargin;
- (FYConstraint *)topMargin;
- (FYConstraint *)bottomMargin;
- (FYConstraint *)leadingMargin;
- (FYConstraint *)trailingMargin;
- (FYConstraint *)centerXWithinMargins;
- (FYConstraint *)centerYWithinMargins;

#endif

- (FYConstraint * (^)(id key))key;
- (void)setInsets:(FYEdgeInsets)insets;
- (void)setInset:(CGFloat)inset;
- (void)setSizeOffset:(CGSize)sizeOffset;
- (void)setCenterOffset:(CGPoint)centerOffset;
- (void)setOffset:(CGFloat)offset;

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

@property (nonatomic, copy, readonly) FYConstraint *animator;

#endif

- (void)activate;
- (void)deactivate;
- (void)install;
- (void)uninstall;

@end

#define fy_equalTo(...)                 equalTo(FYBoxValue((__VA_ARGS__)))
#define fy_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(FYBoxValue((__VA_ARGS__)))
#define fy_lessThanOrEqualTo(...)       lessThanOrEqualTo(FYBoxValue((__VA_ARGS__)))
#define fy_offset(...)                  valueOffset(FYBoxValue((__VA_ARGS__)))

@interface FYConstraint (AutoboxingSupport)

- (FYConstraint * (^)(id attr))fy_equalTo;
- (FYConstraint * (^)(id attr))fy_greaterThanOrEqualTo;
- (FYConstraint * (^)(id attr))fy_lessThanOrEqualTo;
- (FYConstraint * (^)(id offset))fy_offset;

@end
