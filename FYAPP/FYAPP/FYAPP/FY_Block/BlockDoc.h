
#import <UIKit/UIKit.h>

@interface BlockDoc : NSObject

- (void)demo:(void(^)(NSString *str))block;

@end
