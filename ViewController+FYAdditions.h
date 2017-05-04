#import "FYUtilities.h"
#import "FYConstraintMaker.h"
#import "FYViewAttribute.h"

#ifdef FY_VIEW_CONTROLLER

@interface FY_VIEW_CONTROLLER (FYAdditions)

@property (nonatomic, strong, readonly) FYViewAttribute *fy_topLayoutGuide;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_bottomLayoutGuide;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_topLayoutGuideTop;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) FYViewAttribute *fy_bottomLayoutGuideBottom;

@end

#endif
