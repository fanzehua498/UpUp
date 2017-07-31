//
//  NSObject+KVO.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

- (void)Fzh_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

- (void)Fzh_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
@end
