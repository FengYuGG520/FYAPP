#import "FYConstraint.h"
#import "FYUtilities.h"

typedef NS_OPTIONS(NSInteger, FYAttribute) {
    FYAttributeLeft = 1 << NSLayoutAttributeLeft,
    FYAttributeRight = 1 << NSLayoutAttributeRight,
    FYAttributeTop = 1 << NSLayoutAttributeTop,
    FYAttributeBottom = 1 << NSLayoutAttributeBottom,
    FYAttributeLeading = 1 << NSLayoutAttributeLeading,
    FYAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    FYAttributeWidth = 1 << NSLayoutAttributeWidth,
    FYAttributeHeight = 1 << NSLayoutAttributeHeight,
    FYAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    FYAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    FYAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    FYAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    FYAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    FYAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    FYAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    FYAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    FYAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    FYAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    FYAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    FYAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    FYAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,
    
#endif
    
};

@interface FYConstraintMaker : NSObject

@property (nonatomic, strong, readonly) FYConstraint *left;
@property (nonatomic, strong, readonly) FYConstraint *top;
@property (nonatomic, strong, readonly) FYConstraint *right;
@property (nonatomic, strong, readonly) FYConstraint *bottom;
@property (nonatomic, strong, readonly) FYConstraint *leading;
@property (nonatomic, strong, readonly) FYConstraint *trailing;
@property (nonatomic, strong, readonly) FYConstraint *width;
@property (nonatomic, strong, readonly) FYConstraint *height;
@property (nonatomic, strong, readonly) FYConstraint *centerX;
@property (nonatomic, strong, readonly) FYConstraint *centerY;
@property (nonatomic, strong, readonly) FYConstraint *baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) FYConstraint *firstBaseline;
@property (nonatomic, strong, readonly) FYConstraint *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) FYConstraint *leftMargin;
@property (nonatomic, strong, readonly) FYConstraint *rightMargin;
@property (nonatomic, strong, readonly) FYConstraint *topMargin;
@property (nonatomic, strong, readonly) FYConstraint *bottomMargin;
@property (nonatomic, strong, readonly) FYConstraint *leadingMargin;
@property (nonatomic, strong, readonly) FYConstraint *trailingMargin;
@property (nonatomic, strong, readonly) FYConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) FYConstraint *centerYWithinMargins;

#endif

@property (nonatomic, strong, readonly) FYConstraint *(^attributes)(FYAttribute attrs);

@property (nonatomic, strong, readonly) FYConstraint *edges;

@property (nonatomic, strong, readonly) FYConstraint *size;

@property (nonatomic, strong, readonly) FYConstraint *center;

@property (assign, nonatomic) BOOL updateExisting;

@property (assign, nonatomic) BOOL removeExisting;

- (id)initWithView:(FY_VIEW *)view;
- (NSArray *)install;
- (FYConstraint * (^)(dispatch_block_t))group;

@end
