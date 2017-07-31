//
//  ImageTool.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/4.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "ImageTool.h"

@implementation ImageTool


-(NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(NSArray *)appList
{
    if (!_appList) {

        //1,加载plist到数组中
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"apps.plist" withExtension:nil];
        NSArray *array = [NSArray arrayWithContentsOfURL:url];
        //2,遍历数组
        NSMutableArray *arrayM = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayM addObject:obj];//数组中存放的是字典，转换为对象后再添加到数组
        }];
        _appList = [arrayM copy];

    }
    return _appList;
}

@end
