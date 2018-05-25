//
//  YBArchiveTool.h
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>


//#ifdef DEBUG
//#define DLog(...) NSLog(@"%s [line %d] %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
//#else
//#define DLog(...)
//#endif


#if defined(DEBUG)
#define YBDPRINT(xx, ...)  NSLog(@"%s(%d行): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define YBDPRINT(xx, ...)  ((void)0)
#endif // #if defined(DEBUG)


@interface YBArchiveTool : NSObject

@end
