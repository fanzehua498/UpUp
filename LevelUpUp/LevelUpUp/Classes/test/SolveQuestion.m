//
//  SolveQuestion.m
//  LevelUpUp
//
//  Created by ydcy-mini on 2017/8/9.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "SolveQuestion.h"

@interface SolveQuestion ()
@property (nonatomic, assign) NSInteger tatol;

@end

@implementation SolveQuestion

#pragma mark - for循环、while循环和递归计算数列的总和

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


- (NSInteger )useMe:(NSMutableArray *)arr
{
    if (arr.count > 0) {
        NSNumber *numb = arr.firstObject;
        self.tatol += numb.integerValue;
        [self useMe:arr];
    }
    NSInteger tat = self.tatol;
    self.tatol = 0;
    return tat;

}
-(NSInteger)tatol
{
    if (!_tatol) {
        _tatol = 0;
    }
    return _tatol;
}

#pragma mark - 交错合并列表元素
- (void)addArrOne:(NSArray *)arr1 arrTwo:(NSArray *)arr2
{
    NSMutableArray *finalArr = [NSMutableArray array];
    if (arr1.count == arr2.count) {
        for (int i = 0; i<arr1.count; i ++) {
            [finalArr addObject:arr1[i]];
            [finalArr addObject:arr2[i]];
        }

    }else{

        NSInteger count = arr1.count > arr2.count ? arr2.count : arr1.count;
        for (int i = 0; i < count; i ++) {
            [finalArr addObject:arr1[i]];
            [finalArr addObject:arr2[i]];
        }

        NSMutableArray *arr = [NSMutableArray arrayWithArray:arr1.count > count ? arr1:arr2];
        [arr removeObjectsInArray:finalArr];
        [finalArr addObjectsFromArray:arr];
    }
    NSLog(@"finalArr:%@",finalArr);
}

@end
