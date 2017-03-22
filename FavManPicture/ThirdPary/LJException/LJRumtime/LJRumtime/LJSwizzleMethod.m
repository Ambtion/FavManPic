//
//  LJSwizzMethod.m
//  LJRumtime
//
//  Created by LJH on 15/12/29.
//  Copyright © 2015年 LJ. All rights reserved.
//

#import "LJSwizzleMethod.h"

#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

#define SETERROR(FUNC,ERROR_VAR,FORMAT,...) \
    if(ERROR_VAR){\
        NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
        *ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
        code:-1	\
        userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
    }

#define SETFORMATRROR(ERROR_VAR,FORMAT,...) SETERROR(__func__,ERROR_VAR,FORMAT,##__VA_ARGS__)

@implementation LJSwizzleMethod

+ (BOOL)swizzClassInstanceMethod:(Class)class oriMethod:(SEL)ori withMethod:(SEL)dis error:(NSError **)error
{
    return [self swizzClassMethod:class methodType:NO oriMethod:ori withMethod:dis error:error];
}


+ (BOOL)swizzClassClassMethod:(Class)class oriMethod:(SEL)ori withMethod:(SEL)dis error:(NSError **)error
{
    return [self swizzClassMethod:class methodType:YES oriMethod:ori withMethod:dis error:error];
}

#pragma private
+ (BOOL)swizzClassMethod:(Class)class methodType:(BOOL)isClassMethod oriMethod:(SEL)ori withMethod:(SEL)dis error:(NSError **)error
{
    Method oriMethod = NULL;
    Method disMethod = NULL;
    if (isClassMethod) {
        oriMethod = class_getClassMethod(class, ori);
        disMethod = class_getClassMethod(class, dis);
    }else{
        oriMethod = class_getInstanceMethod(class, ori);
        disMethod = class_getInstanceMethod(class, dis);
    }
    
    if (!oriMethod) {
        SETFORMATRROR(error, @"original method %@ not found for class %@", NSStringFromSelector(ori), [self class]);
        return NO;
    }
    if (!disMethod) {
        SETFORMATRROR(error, @"Dis method %@ not found for class %@", NSStringFromSelector(dis), [self class]);
        return NO;
    }
    
    
    
    BOOL didAddMethod = class_addMethod(class, ori, method_getImplementation(disMethod), method_getTypeEncoding(disMethod));
    if (didAddMethod) {
        class_replaceMethod(class, dis, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, disMethod);
    }
    
    return YES;
    
}


@end
