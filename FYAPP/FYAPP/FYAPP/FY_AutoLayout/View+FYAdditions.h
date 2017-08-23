#import "FYUtilities.h"
#import "FYConstraintMaker.h"
#import "FYViewAttribute.h"

@interface FY_VIEW (FYAdditions)

@property (nonatomic, strong, readonly) FYViewAttribute *fy_left;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_top;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_right;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_bottom;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_leading;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_trailing;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_width;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_height;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_centerX;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_centerY;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_baseline;
@property (nonatomic, strong, readonly) FYViewAttribute *(^fy_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) FYViewAttribute *fy_firstBaseline;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) FYViewAttribute *fy_leftMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_rightMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_topMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_bottomMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_leadingMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_trailingMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_centerXWithinMargins;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_centerYWithinMargins;

#endif

@property (strong, nonatomic) id fy_key;

- (instancetype)fy_closestCommonSuperview:(FY_VIEW *)view;
- (NSArray *)fy_makeConstraints:(void(NS_NOESCAPE ^)(FYConstraintMaker *make))block;
- (NSArray *)fy_updateConstraints:(void(NS_NOESCAPE ^)(FYConstraintMaker *make))block;
- (NSArray *)fy_remakeConstraints:(void(NS_NOESCAPE ^)(FYConstraintMaker *make))block;

@end
