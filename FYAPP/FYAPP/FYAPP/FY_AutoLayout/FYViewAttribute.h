#import "FYUtilities.h"

@interface FYViewAttribute : NSObject

@property (nonatomic, weak, readonly) FY_VIEW *view;
@property (nonatomic, weak, readonly) id item;
@property (nonatomic, assign, readonly) NSLayoutAttribute layoutAttribute;

- (id)initWithView:(FY_VIEW *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute;
- (id)initWithView:(FY_VIEW *)view item:(id)item layoutAttribute:(NSLayoutAttribute)layoutAttribute;
- (BOOL)isSizeAttribute;

@end
