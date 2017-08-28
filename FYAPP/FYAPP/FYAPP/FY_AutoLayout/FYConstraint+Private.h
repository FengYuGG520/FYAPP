#import "FYConstraint.h"

@protocol FYConstraintDelegate;

@interface FYConstraint ()

@property (assign, nonatomic) BOOL updateExisting;

@property (weak, nonatomic) id<FYConstraintDelegate> delegate;

- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface FYConstraint (Abstract)

- (FYConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;
- (FYConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end

@protocol FYConstraintDelegate <NSObject>

- (void)constraint:(FYConstraint *)constraint shouldBeReplacedWithConstraint:(FYConstraint *)replacementConstraint;

- (FYConstraint *)constraint:(FYConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end
