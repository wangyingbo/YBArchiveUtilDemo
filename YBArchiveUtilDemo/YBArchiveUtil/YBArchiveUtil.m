//
//  YBArchiveUtil.m
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "YBArchiveUtil.h"
#import "YBArchiveUtilHeader.h"


#define DEFAULT_STORE_PATH_KEY @"kYBStorePathKey"
#define DEFAULT_STORE_PATH_NAME @"kYBDefaultPathName"

@implementation YBArchiveUtil

+ (void)setPlistPathName:(NSString *)pathName {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultPathName = [defaults objectForKey:DEFAULT_STORE_PATH_KEY];
    if (defaultPathName) { return; }
    
    [defaults setObject:(pathName?pathName:DEFAULT_STORE_PATH_NAME) forKey:DEFAULT_STORE_PATH_KEY];
    [defaults synchronize];
}

+ (BOOL)saveObject:(id)obj withFilePathName:(NSString *)filePathName {
    //判断obj里是否实现了归档方法
    if (![self checkEncodeWithCoder:obj]) {
        YBDPRINT(@"%@ 没有实现EncodeWithCoder方法",obj);
        YBDASSERT([self checkEncodeWithCoder:obj]);
        return NO;
    }
    
    return [NSKeyedArchiver archiveRootObject:obj toFile:[self getFilePathWithFilePathName:filePathName]];
}

+ (id)getObjectWithFilePathName:(NSString *)filePathName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePathWithFilePathName:filePathName]];
}

+ (BOOL)removeObjectWithFilePathName:(NSString *)filePathName {
    if (!filePathName) {//没有路径名时
        YBDASSERT(filePathName);
        return NO;
    }
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:[self getFilePathWithFilePathName:filePathName]];
    if (exist) {
        exist =  [fileManager removeItemAtPath:[self getFilePathWithFilePathName:filePathName] error:nil];
    }
    
    return exist;
}

+ (BOOL)saveObjects:(NSArray *)objs forFlag:(NSString*)flag withFilePathName:(NSString *)filePathName
{
    if (!objs || objs.count<1) { return NO; }
    
    //判断objs每个数据里是否实现了归档方法
    for (id obj in objs) {
        if (![self checkEncodeWithCoder:obj]) {
            YBDPRINT(@"%@ 没有实现EncodeWithCoder方法",obj);
            YBDASSERT([self checkEncodeWithCoder:obj]);
            return NO;
        }
    }
    
    NSMutableData * data = [[NSMutableData alloc]init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:objs forKey:flag];
    [archiver finishEncoding];
    
    BOOL success =  [data writeToFile:[self getFilePathWithFilePathName:filePathName] atomically:YES];
    
    return success;
}

+ (NSArray *)getObjectsForFlag:(NSString*)flag withFilePathName:(NSString *)filePathName
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithFilePathName:filePathName]];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray * array = [unarchiver decodeObjectForKey:flag];
    
    return array;
}

/**
 检查是否遵守了NSCoding协议，是否实现了归档方法

 @param obj 待归档解档的对象
 @return 检查结果状态
 */
+ (BOOL)checkEncodeWithCoder:(id)obj {
    // && [obj conformsToProtocol:@protocol(NSCoding)]
    return ([obj respondsToSelector:@selector(encodeWithCoder:)]);
}

/**
 根据文件名取回路径

 @param filePathName 文件名
 @return 路径
 */
+ (NSString*)getFilePathWithFilePathName:(NSString *)filePathName
{
    NSString *path = @"";
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cache = [documentsPathArr firstObject];
    
    if (filePathName && filePathName.length>0) {
        path = [NSString stringWithFormat:@"%@/%@.plist",cache,filePathName];
    }else {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString *pathName = [defaults valueForKey:DEFAULT_STORE_PATH_KEY];
        
        if (pathName) {
            path = [NSString stringWithFormat:@"%@/%@.plist",cache,pathName];
        }else {
            [defaults setObject:DEFAULT_STORE_PATH_NAME forKey:DEFAULT_STORE_PATH_KEY];
            path = [NSString stringWithFormat:@"%@/%@.plist",cache,DEFAULT_STORE_PATH_NAME];
        }
    }
    
    return path;
}

@end
