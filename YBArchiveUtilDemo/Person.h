//
//  Person.h
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Child : NSObject
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *school;
@end


@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign)int age;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NSNumber *tagNumber;
@property (nonatomic, strong) Child *child;

@end
