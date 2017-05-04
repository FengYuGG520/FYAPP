#import "FYUtilities.h"
#import "FYConstraintMaker.h"
#import "FYViewAttribute.h"

typedef NS_ENUM(NSUInteger, FYAxisType) {
    FYAxisTypeHorizontal,
    FYAxisTypeVertical
};

@interface NSArray (FYAdditions)

- (NSArray *)fy_makeConstraints:(void (NS_NOESCAPE ^)(FYConstraintMaker *make))block;

- (NSArray *)fy_updateConstraints:(void (NS_NOESCAPE ^)(FYConstraintMaker *make))block;

- (NSArray *)fy_remakeConstraints:(void (NS_NOESCAPE ^)(FYConstraintMaker *make))block;

- (void)fy_distributeViewsAlongAxis:(FYAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

- (void)fy_distributeViewsAlongAxis:(FYAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

@end
