//
//  CacheResearch.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/11/3.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "CacheResearch.h"

@implementation CacheResearch

- (void)whatCache
{
    NSCache *cache = [[NSCache alloc] init];
    cache.totalCostLimit = 1024 * 8;
    cache.countLimit = 1024 * 3;
}

@end
