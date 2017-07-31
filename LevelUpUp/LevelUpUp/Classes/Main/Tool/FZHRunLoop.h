//
//  FZHRunLoop.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/26.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^runloopBlock)();

@interface FZHRunLoop : NSObject
/** 操作任务列表 */
@property (nonatomic, strong) NSMutableArray  *tasks;
/** 最大任务数 */
@property (nonatomic, assign) NSUInteger maxQueue;
// 添加观察
-(void)addRunLoopObserver;
//定义一个添加任务的方法
- (void)addTask:(runloopBlock)task;
@end
