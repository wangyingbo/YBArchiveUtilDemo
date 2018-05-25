//
//  YBArchiveTool.m
//  YBArchiveUtilDemo
//
//  Created by 王迎博 on 2018/5/25.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "YBArchiveTool.h"


BOOL YBDebugAssertionsShouldBreak = YES;
#if defined(DEBUG)
#import <TargetConditionals.h>
#import <unistd.h>
#import <sys/sysctl.h>
// From: http://developer.apple.com/mac/library/qa/qa2004/qa1361.html
int YBIsInDebugger(void) {
    int mib[4];
    struct kinfo_proc info;
    size_t size;
    info.kp_proc.p_flag = 0;
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
    size = sizeof(info);
    sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    return (info.kp_proc.p_flag & P_TRACED) != 0;
}
#endif




@implementation YBArchiveTool
@end
