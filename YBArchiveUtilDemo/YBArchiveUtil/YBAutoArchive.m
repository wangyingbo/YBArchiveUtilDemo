//
//  YBAutoArchiveUtil.m
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "YBAutoArchive.h"
#import <objc/runtime.h>
#import "YBArchiveUtil.h"
#import "YBArchiveUtilHeader.h"

@implementation YBAutoArchive

//TODO:自动归档解档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray * properNames = [self properNames];
    for (NSString * properName in properNames) {
        id value = [self valueForKey:properName];
        //归档到文件中
        if (![YBArchiveUtil checkEncodeWithCoder:value]) {
            YBDPRINT(@"%@ 没有实现EncodeWithCoder方法",value);
            YBDASSERT([YBArchiveUtil checkEncodeWithCoder:value]);
        }
        [aCoder encodeObject:value forKey:properName];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        NSArray * properNames = [self properNames];
        for (NSString * properName in properNames) {
            id value = [aDecoder decodeObjectForKey:properName];
            [self setValue:value forKey:properName];
        }
    }
    return self;
}

- (NSArray<NSString*>*)properNames {
    unsigned int count;
    Ivar * ivarList = class_copyIvarList([self class], &count);
    NSMutableArray * propers = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        //获取成员属性名
        NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //出去下划线
        NSString * key = [name substringFromIndex:1];
        [propers addObject:key];
    }
    return propers;
}

@end
