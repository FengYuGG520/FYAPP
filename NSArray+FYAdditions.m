#import "NSArray+FYAdditions.h"
#import "View+FYAdditions.h"

@implementation NSArray (FYAdditions)

- (NSArray *)fy_makeConstraints:(void(^)(FYConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (FY_VIEW *view in self) {
        NSAssert([view isKindOfClass:[FY_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view fy_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)fy_updateConstraints:(void(^)(FYConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (FY_VIEW *view in self) {
        NSAssert([view isKindOfClass:[FY_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view fy_updateConstraints:block]];
    }
    return constraints;
}

- (NSArray *)fy_remakeConstraints:(void(^)(FYConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (FY_VIEW *view in self) {
        NSAssert([view isKindOfClass:[FY_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view fy_remakeConstraints:block]];
    }
    return constraints;
}

- (void)fy_distributeViewsAlongAxis:(FYAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    FY_VIEW *tempSuperView = [self fy_commonSuperviewOfViews];
    if (axisType == FYAxisTypeHorizontal) {
        FY_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            FY_VIEW *v = self[i];
            [v fy_makeConstraints:^(FYConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.fy_right).offset(fixedSpacing);
                    if (i == self.count - 1) {
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        FY_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            FY_VIEW *v = self[i];
            [v fy_makeConstraints:^(FYConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.fy_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)fy_distributeViewsAlongAxis:(FYAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    FY_VIEW *tempSuperView = [self fy_commonSuperviewOfViews];
    if (axisType == FYAxisTypeHorizontal) {
        FY_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            FY_VIEW *v = self[i];
            [v fy_makeConstraints:^(FYConstraintMaker *make) {
                make.width.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        FY_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            FY_VIEW *v = self[i];
            [v fy_makeConstraints:^(FYConstraintMaker *make) {
                make.height.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (FY_VIEW *)fy_commonSuperviewOfViews
{
    FY_VIEW *commonSuperview = nil;
    FY_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[FY_VIEW class]]) {
            FY_VIEW *view = (FY_VIEW *)object;
            if (previousView) {
                commonSuperview = [view fy_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
