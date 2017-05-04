#import "ViewController+FYAdditions.h"

#ifdef FY_VIEW_CONTROLLER

@implementation FY_VIEW_CONTROLLER (FYAdditions)

- (FYViewAttribute *)fy_topLayoutGuide {
    return [[FYViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (FYViewAttribute *)fy_topLayoutGuideTop {
    return [[FYViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (FYViewAttribute *)fy_topLayoutGuideBottom {
    return [[FYViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (FYViewAttribute *)fy_bottomLayoutGuide {
    return [[FYViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (FYViewAttribute *)fy_bottomLayoutGuideTop {
    return [[FYViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (FYViewAttribute *)fy_bottomLayoutGuideBottom {
    return [[FYViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

@end

#endif
