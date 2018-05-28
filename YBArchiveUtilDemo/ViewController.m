//
//  ViewController.m
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "YBArchiveUtilHeader.h"

@interface ViewController ()

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(100, 100,150, 40);
    btn1.center = CGPointMake(self.view.center.x, btn1.center.y);
    [btn1 setTitle:@"归档单个对象" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(archiverSingle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor orangeColor];
    btn2.frame = CGRectMake(100, 150, 150, 40);
    btn2.center = CGPointMake(self.view.center.x, btn2.center.y);
    [btn2 setTitle:@"解档单个对象" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(unarchiverSingle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = [UIColor purpleColor];
    btn3.frame = CGRectMake(100, 200, 150, 40);
    btn3.center = CGPointMake(self.view.center.x, btn3.center.y);
    [btn3 setTitle:@"归档多个对象" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(archiverMutable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.backgroundColor = [UIColor blueColor];
    btn4.frame = CGRectMake(100, 250, 150, 40);
    btn4.center = CGPointMake(self.view.center.x, btn4.center.y);
    [btn4 setTitle:@"解档多个对象" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(unarchiverMutable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    //YBDPRINT(@"test the print");
}

#pragma mark - private
- (void)archiverSingle
{
    Person *p = [[Person alloc]init];
    p.name = @"张三";
    p.age = 20;
    p.ID = 0;
    p.isShow = YES;
    p.tagNumber = @5;
    
    Child *child = [[Child alloc]init];
    child.nickName = @"狗蛋儿";
    child.school = @"春田花花幼儿园";
    //p.child = child;
    
    BOOL success = [YBArchiveUtil saveObject:p withFilePathName:@"single"];
    
    if (success) {
        NSLog(@"归档单个对象成功");
    } else {
        NSLog(@"归档单个对象失败");
    }
    
}

- (void)unarchiverSingle
{
    Person * p = [YBArchiveUtil getObjectWithFilePathName:@"single"];
    NSLog(@"-------姓名=%@-------年龄=%d-------ID=%ld-------boo值=%@-------number型=%@-------child昵称=%@-------child学校=%@",p.name,p.age,(long)p.ID,(p.isShow?@"yes":@"no"),p.tagNumber,p.child.nickName,p.child.school);
}

- (void)archiverMutable
{
    NSMutableArray * data = [NSMutableArray array];
    
    for (int i = 0; i<10; i++)
    {
        Person * p = [[Person alloc]init];
        p.name = [NSString stringWithFormat:@"李四%d",i];
        p.age = 10+i;
        p.ID = i;
        
        Child *child = [[Child alloc] init];
        child.nickName = @"二妞儿";
        child.school = @"霍格沃兹";
        p.child = child;
        
        [data addObject:p];
    }
    
    BOOL success =  [YBArchiveUtil saveObjects:data forFlag:@"flag1" withFilePathName:@"multi"];
    
    if (success) {
        NSLog(@"归档多个对象成功");
    } else {
        NSLog(@"归档多个对象失败");
    }
}

- (void)unarchiverMutable
{
    NSArray * data =[YBArchiveUtil getObjectsForFlag:@"flag1" withFilePathName:@"multi"];
    
    NSLog(@"---------------%@",data);
}
@end
