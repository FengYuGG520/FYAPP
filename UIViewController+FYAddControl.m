#import "UIViewController+FYAddControl.h"

@implementation UIViewController (FYAddControl)

- (void)fy_addController:(UIViewController *)controller viewTo:(UIView *)view {
    
    [self addChildViewController:controller];
    [view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}

@end
