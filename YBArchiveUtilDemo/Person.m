//
//  Person.m
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "Person.h"
#import "YBArchiveUtilHeader.h"

@implementation Child
YB_IMPLEMENTATION_CODE_WITH_CODER
@end


@implementation Person

YB_IMPLEMENTATION_CODE_WITH_CODER

- (NSString*)description
{
    return [NSString stringWithFormat:@"[Person cass]"];
}
@end
