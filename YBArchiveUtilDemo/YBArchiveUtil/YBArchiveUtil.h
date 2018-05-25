//
//  YBArchiveUtil.h
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YBAutoArchive;

@interface YBArchiveUtil : NSObject


/**
 指定默认保存数据的文件名，全局只用设置一次

 @param pathName 文件名
 */
+ (void)setPlistPathName:(NSString*)pathName;

/**
 保存单个数据

 @param obj 实现了归档的对象
 @param filePathName 文件名，如果传值nil，则会保存在默认的defaultPathName里
 @return 保存状态
 */
+ (BOOL)saveObject:(id)obj withFilePathName:(NSString *)filePathName;

/**
 取出单个数据

 @param filePathName 文件名，如果传值nil，则会在默认的defaultPathName里取
 @return 对象
 */
+ (id)getObjectWithFilePathName:(NSString *)filePathName;

/**
 移除文件名下的对象

 @param filePathName 文件名，如果传值nil，则return
 @return 执行结果
 */
+ (BOOL)removeObjectWithFilePathName:(NSString *)filePathName;

/**
 保存多个数据

 @param objs 多个数据数组
 @param flag flag description
 @param filePathName 文件名，如果传值nil，则会保存在默认的defaultPathName里
 @return 保存状态
 */
+ (BOOL)saveObjects:(NSArray *)objs forFlag:(NSString*)flag withFilePathName:(NSString *)filePathName;

/**
 取多个数据

 @param flag flag description
 @param filePathName 文件名，如果传值nil，则会在默认的defaultPathName里取
 @return 多个数据的数组
 */
+ (NSArray *)getObjectsForFlag:(NSString*)flag withFilePathName:(NSString *)filePathName;

@end
