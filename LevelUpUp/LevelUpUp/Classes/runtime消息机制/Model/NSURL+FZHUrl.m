//
//  NSURL+FZHUrl.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#warning hook钩子的使用

#import "NSURL+FZHUrl.h"
#import <objc/runtime.h>
@implementation NSURL (FZHUrl)
+(void)load
{
    //class_getClassMethod 获取类方法
    //class_getInstanceMethod 获取实例方法
    //可以将系统方法替换为自己的方法
    Method methodSys = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method methodSelf = class_getClassMethod([NSURL class], @selector(fzhURlWithString:));
    method_exchangeImplementations(methodSys, methodSelf);
}
//已经使用runtime改变了 方法指向
+(instancetype)fzhURlWithString:(NSString *)urls
{
    NSURL *url = [NSURL fzhURlWithString:urls];
    if (!url) {
        NSAssert(url, @"请求链接为空");
    }
    return url;
}

@end
