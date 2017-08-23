#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE || TARGET_OS_TV

#import <UIKit/UIKit.h>
#define FY_VIEW UIView
#define FY_VIEW_CONTROLLER UIViewController
#define FYEdgeInsets UIEdgeInsets

typedef UILayoutPriority FYLayoutPriority;
static const FYLayoutPriority FYLayoutPriorityRequired = UILayoutPriorityRequired;
static const FYLayoutPriority FYLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh;
static const FYLayoutPriority FYLayoutPriorityDefaultMedium = 500;
static const FYLayoutPriority FYLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow;
static const FYLayoutPriority FYLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel;

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>
#define FY_VIEW NSView
#define FYEdgeInsets NSEdgeInsets

typedef NSLayoutPriority FYLayoutPriority;
static const FYLayoutPriority FYLayoutPriorityRequired = NSLayoutPriorityRequired;
static const FYLayoutPriority FYLayoutPriorityDefaultHigh = NSLayoutPriorityDefaultHigh;
static const FYLayoutPriority FYLayoutPriorityDragThatCanResizeWindow = NSLayoutPriorityDragThatCanResizeWindow;
static const FYLayoutPriority FYLayoutPriorityDefaultMedium = 501;
static const FYLayoutPriority FYLayoutPriorityWindowSizeStayPut = NSLayoutPriorityWindowSizeStayPut;
static const FYLayoutPriority FYLayoutPriorityDragThatCannotResizeWindow = NSLayoutPriorityDragThatCannotResizeWindow;
static const FYLayoutPriority FYLayoutPriorityDefaultLow = NSLayoutPriorityDefaultLow;
static const FYLayoutPriority FYLayoutPriorityFittingSizeCompression = NSLayoutPriorityFittingSizeCompression;

#endif

#define FYAttachKeys(...)                                                        \
{                                                                             \
NSDictionary *keyPairs = NSDictionaryOfVariableBindings(__VA_ARGS__);     \
for (id key in keyPairs.allKeys) {                                        \
id obj = keyPairs[key];                                               \
NSAssert([obj respondsToSelector:@selector(setFy_key:)],             \
@"Cannot attach fy_key to %@", obj);                        \
[obj setFy_key:key];                                                 \
}                                                                         \
}


#define FY_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define FY_NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (FY_NSUINT_BIT - howmuch)))

static inline id _FYBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(FYEdgeInsets)) == 0) {
        FYEdgeInsets actual = (FYEdgeInsets)va_arg(v, FYEdgeInsets);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

#define FYBoxValue(value) _FYBoxValue(@encode(__typeof__((value))), (value))
