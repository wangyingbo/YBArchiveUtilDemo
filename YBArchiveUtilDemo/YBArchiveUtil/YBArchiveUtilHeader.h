
//
//  YBArchiveUtilHeader.h
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#ifndef YBArchiveUtilHeader_h
#define YBArchiveUtilHeader_h

#pragma mark - 头文件引用
#import <Foundation/Foundation.h>
#import "YBArchiveUtil.h"
#import "YBAutoArchive.h"
#import "YBArchiveTool.h"
#import <objc/runtime.h>

#pragma mark - 实现归档解档的宏
/**实现归档解档的宏*/
#define YB_IMPLEMENTATION_CODE_WITH_CODER \
- (void)encodeWithCoder:(NSCoder *)aCoder { \
    NSArray * properNames = [self properNames]; \
    for (NSString * properName in properNames) { \
        id value = [self valueForKey:properName]; \
        if (value && properName) { \
            [aCoder encodeObject:value forKey:properName]; \
        } \
    } \
} \
 \
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
    if (self = [super init]) { \
        NSArray * properNames = [self properNames]; \
        for (NSString * properName in properNames) { \
            id value = [aDecoder decodeObjectForKey:properName]; \
            if (value && properName) { \
                [self setValue:value forKey:properName]; \
            } \
        } \
    } \
    return self; \
} \
 \
- (NSArray<NSString*>*)properNames { \
    unsigned int count; \
    Ivar * ivarList = class_copyIvarList([self class], &count); \
    NSMutableArray * propers = [NSMutableArray array]; \
    for (int i = 0; i<count; i++) { \
        Ivar ivar = ivarList[i]; \
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];\
        NSString * key = [name substringFromIndex:1]; \
        [propers addObject:key]; \
    } \
    return propers; \
}


#pragma mark - C函数的extern
#if defined __cplusplus
extern "C" {
#endif
    
    int YBIsInDebugger(void);
    
#if defined __cplusplus
};
#endif



#pragma mark - 实现自定义断言的宏
//此字段定义遇到断言时是否断点定位到代码行
extern BOOL YBDebugAssertionsShouldBreak;

#if defined(DEBUG)
#if TARGET_IPHONE_SIMULATOR
// 在宏定义中用__asm__
#define YBDASSERT(xx) { if (!(xx)) { YBDPRINT(@"YBDASSERT failed: %s", #xx); \
if (YBDebugAssertionsShouldBreak && YBIsInDebugger()) { __asm__("int $3\n" : : ); } } \
} ((void)0)
#else
#define YBDASSERT(xx) { if (!(xx)) { YBDPRINT(@"YBDASSERT failed: %s", #xx); \
if (YBDebugAssertionsShouldBreak && YBIsInDebugger()) { raise(SIGTRAP); } } \
} ((void)0)
#endif // #if TARGET_IPHONE_SIMULATOR
#else
#define YBDASSERT(xx) ((void)0)
#endif // #if DEBUG

#pragma mark - 其他



#endif /* YBArchiveUtilHeader_h */
