//
//  SolveQuestion.m
//  LevelUpUp
//
//  Created by ydcy-mini on 2017/8/9.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "SolveQuestion.h"

@implementation SolveQuestion

- (NSInteger)forSum:(NSArray *)number
{
    NSInteger tatol = 0;
    if (number.count > 0) {

        for (int i = 0; i < number.count; i ++) {
            tatol = tatol + (NSInteger)number[i];
        }
    }
    return tatol;
}

- (NSInteger)whileSum:(NSMutableArray *)number
{
    NSInteger tatol = 0;

    while (number.count > 0) {
        NSNumber *numb = number.firstObject;
        tatol += numb.integerValue;
        [number removeObjectAtIndex:0];
    }

    return tatol;
}

@end
