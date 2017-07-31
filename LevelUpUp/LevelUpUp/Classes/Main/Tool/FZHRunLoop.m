//
//  FZHRunLoop.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/26.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//  高级使用runloop

#import "FZHRunLoop.h"


@interface FZHRunLoop ()


@end

@implementation FZHRunLoop



//定义一个添加任务的方法
- (void)addTask:(runloopBlock)task{
    //将任务添加到数组
    [self.tasks addObject:task];
    //保证之前没有来得及显示的cell不会绘制图片
    if (self.tasks.count > self.maxQueue) {
        [self.tasks removeObjectAtIndex:0];
    }
}



-(void)addRunLoopObserver
{
    //1,获取当前runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();

    //定义context
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };

    //2,定义观察者
    static CFRunLoopObserverRef defaultmodelObserver ;
    //创建观察者
    /**
     *
     *
     */
   defaultmodelObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &CallBack, &context);

    //创建观察者
    CFRunLoopAddObserver(runloop, defaultmodelObserver, kCFRunLoopCommonModes);
    //c语言中有create就需要release
    CFRelease(defaultmodelObserver);
}
static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
//    info ： context传递的第二个参数
    NSLog(@"callBack");
    //处理控制器价值耗时的事情

    FZHRunLoop *vc = (__bridge FZHRunLoop *)(info);
    if (vc.tasks.count == 0) {
        return;
    }
    //拿出任务
    runloopBlock task = vc.tasks.firstObject;
    //执行任务
    task();
    //干掉任务
    [vc.tasks removeObjectAtIndex:0];
}
@end
