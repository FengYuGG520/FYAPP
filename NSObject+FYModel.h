#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (FYModel)

+ (nullable instancetype)fy_modelWithJSON:(id)json;
+ (nullable instancetype)fy_modelWithDictionary:(NSDictionary *)dictionary;
- (BOOL)fy_modelSetWithJSON:(id)json;
- (BOOL)fy_modelSetWithDictionary:(NSDictionary *)dic;
- (nullable id)fy_modelToJSONObject;
- (nullable NSData *)fy_modelToJSONData;
- (nullable NSString *)fy_modelToJSONString;
- (nullable id)fy_modelCopy;
- (void)fy_modelEncodeWithCoder:(NSCoder *)aCoder;
- (id)fy_modelInitWithCoder:(NSCoder *)aDecoder;
- (NSUInteger)fy_modelHash;
- (BOOL)fy_modelIsEqual:(id)model;
- (NSString *)fy_modelDescription;

@end

@interface NSArray (FYModel)

+ (nullable NSArray *)fy_modelArrayWithClass:(Class)cls json:(id)json;

@end

@interface NSDictionary (FYModel)

+ (nullable NSDictionary *)fy_modelDictionaryWithClass:(Class)cls json:(id)json;

@end

@protocol FYModel <NSObject>
@optional
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass;
+ (nullable Class)modelCustomClassForDictionary:(NSDictionary *)dictionary;
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist;
+ (nullable NSArray<NSString *> *)modelPropertyWhitelist;
- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
