#import "FYViewAttribute.h"
#import "FYLayoutConstraint.h"
#import "FYUtilities.h"
#import "FYConstraint.h"

@interface FYViewConstraint : FYConstraint <NSCopying>

@property (nonatomic, strong, readonly) FYViewAttribute *firstViewAttribute;
@property (nonatomic, strong, readonly) FYViewAttribute *secondViewAttribute;

- (id)initWithFirstViewAttribute:(FYViewAttribute *)firstViewAttribute;
+ (NSArray *)installedConstraintsForView:(FY_VIEW *)view;

@end
