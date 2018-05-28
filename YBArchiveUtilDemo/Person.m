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
    [NSString stringWithFormat:@"%@",[self class]];
    
    return [NSString stringWithFormat:@"-------姓名=%@-------年龄=%d-------ID=%ld-------boo值=%@-------number型=%@-------child昵称=%@-------child学校=%@",self.name,self.age,(long)self.ID,(self.isShow?@"yes":@"no"),self.tagNumber,self.child.nickName,self.child.school];
}
@end
