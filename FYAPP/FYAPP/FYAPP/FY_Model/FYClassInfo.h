#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, FYEncodingType) {
    FYEncodingTypeMask       = 0xFF,
    FYEncodingTypeUnknown    = 0,
    FYEncodingTypeVoid       = 1,
    FYEncodingTypeBool       = 2,
    FYEncodingTypeInt8       = 3,
    FYEncodingTypeUInt8      = 4,
    FYEncodingTypeInt16      = 5,
    FYEncodingTypeUInt16     = 6,
    FYEncodingTypeInt32      = 7,
    FYEncodingTypeUInt32     = 8,
    FYEncodingTypeInt64      = 9,
    FYEncodingTypeUInt64     = 10,
    FYEncodingTypeFloat      = 11,
    FYEncodingTypeDouble     = 12,
    FYEncodingTypeLongDouble = 13,
    FYEncodingTypeObject     = 14,
    FYEncodingTypeClass      = 15,
    FYEncodingTypeSEL        = 16,
    FYEncodingTypeBlock      = 17,
    FYEncodingTypePointer    = 18,
    FYEncodingTypeStruct     = 19,
    FYEncodingTypeUnion      = 20,
    FYEncodingTypeCString    = 21,
    FYEncodingTypeCArray     = 22,
    
    FYEncodingTypeQualifierMask   = 0xFF00,
    FYEncodingTypeQualifierConst  = 1 << 8,
    FYEncodingTypeQualifierIn     = 1 << 9,
    FYEncodingTypeQualifierInout  = 1 << 10,
    FYEncodingTypeQualifierOut    = 1 << 11,
    FYEncodingTypeQualifierBycopy = 1 << 12,
    FYEncodingTypeQualifierByref  = 1 << 13,
    FYEncodingTypeQualifierOneway = 1 << 14,
    
    FYEncodingTypePropertyMask         = 0xFF0000,
    FYEncodingTypePropertyReadonly     = 1 << 16,
    FYEncodingTypePropertyCopy         = 1 << 17,
    FYEncodingTypePropertyRetain       = 1 << 18,
    FYEncodingTypePropertyNonatomic    = 1 << 19,
    FYEncodingTypePropertyWeak         = 1 << 20,
    FYEncodingTypePropertyCustomGetter = 1 << 21,
    FYEncodingTypePropertyCustomSetter = 1 << 22,
    FYEncodingTypePropertyDynamic      = 1 << 23,
};

FYEncodingType FYEncodingGetType(const char *typeEncoding);

@interface FYClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) ptrdiff_t offset;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, assign, readonly) FYEncodingType type;

- (instancetype)initWithIvar:(Ivar)ivar;
@end

@interface FYClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) SEL sel;
@property (nonatomic, assign, readonly) IMP imp;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings;

- (instancetype)initWithMethod:(Method)method;
@end

@interface FYClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) FYEncodingType type;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, strong, readonly) NSString *ivarName;
@property (nullable, nonatomic, assign, readonly) Class cls;
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols;
@property (nonatomic, assign, readonly) SEL getter;
@property (nonatomic, assign, readonly) SEL setter;

- (instancetype)initWithProperty:(objc_property_t)property;
@end

@interface FYClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls;
@property (nullable, nonatomic, assign, readonly) Class superCls;
@property (nullable, nonatomic, assign, readonly) Class metaCls;
@property (nonatomic, readonly) BOOL isMeta;
@property (nonatomic, strong, readonly) NSString *name;
@property (nullable, nonatomic, strong, readonly) FYClassInfo *superClassInfo;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, FYClassIvarInfo *> *ivarInfos;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, FYClassMethodInfo *> *methodInfos;
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, FYClassPropertyInfo *> *propertyInfos;

- (void)setNeedUpdate;
- (BOOL)needUpdate;
+ (nullable instancetype)classInfoWithClass:(Class)cls;
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
