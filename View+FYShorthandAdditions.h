#import "View+FYAdditions.h"

#ifdef FY_SHORTHAND

@interface FY_VIEW (FYShorthandAdditions)

@property (nonatomic, strong, readonly) FYViewAttribute *left;
@property (nonatomic, strong, readonly) FYViewAttribute *top;
@property (nonatomic, strong, readonly) FYViewAttribute *right;
@property (nonatomic, strong, readonly) FYViewAttribute *bottom;
@property (nonatomic, strong, readonly) FYViewAttribute *leading;
@property (nonatomic, strong, readonly) FYViewAttribute *trailing;
@property (nonatomic, strong, readonly) FYViewAttribute *width;
@property (nonatomic, strong, readonly) FYViewAttribute *height;
@property (nonatomic, strong, readonly) FYViewAttribute *centerX;
@property (nonatomic, strong, readonly) FYViewAttribute *centerY;
@property (nonatomic, strong, readonly) FYViewAttribute *baseline;
@property (nonatomic, strong, readonly) FYViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) FYViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) FYViewAttribute *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) FYViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *topMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) FYViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) FYViewAttribute *centerYWithinMargins;

#endif

- (NSArray *)makeConstraints:(void(^)(FYConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(FYConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(FYConstraintMaker *make))block;

@end

#define FY_ATTR_FORWARD(attr)  \
- (FYViewAttribute *)attr {    \
return [self fy_##attr];   \
}

@implementation FY_VIEW (FYShorthandAdditions)

FY_ATTR_FORWARD(top);
FY_ATTR_FORWARD(left);
FY_ATTR_FORWARD(bottom);
FY_ATTR_FORWARD(right);
FY_ATTR_FORWARD(leading);
FY_ATTR_FORWARD(trailing);
FY_ATTR_FORWARD(width);
FY_ATTR_FORWARD(height);
FY_ATTR_FORWARD(centerX);
FY_ATTR_FORWARD(centerY);
FY_ATTR_FORWARD(baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

FY_ATTR_FORWARD(firstBaseline);
FY_ATTR_FORWARD(lastBaseline);

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

FY_ATTR_FORWARD(leftMargin);
FY_ATTR_FORWARD(rightMargin);
FY_ATTR_FORWARD(topMargin);
FY_ATTR_FORWARD(bottomMargin);
FY_ATTR_FORWARD(leadingMargin);
FY_ATTR_FORWARD(trailingMargin);
FY_ATTR_FORWARD(centerXWithinMargins);
FY_ATTR_FORWARD(centerYWithinMargins);

#endif

- (FYViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self fy_attribute];
}

- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(FYConstraintMaker *))block {
    return [self fy_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(FYConstraintMaker *))block {
    return [self fy_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(FYConstraintMaker *))block {
    return [self fy_remakeConstraints:block];
}

@end

#endif
