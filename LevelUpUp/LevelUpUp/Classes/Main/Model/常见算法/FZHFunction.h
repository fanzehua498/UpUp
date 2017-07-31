//
//  FZHFunction.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FZHFunction : NSObject
/** 
 二分法
    平均时间复杂度：O(log2n)
 @prarm a       :待查找数列
        number  :带查找的数
 @return index    :number在a中的位置
 */
- (int)halfFunctionIntArr:(NSArray *)a number:(int) number;

/** 
 冒泡排序
 * @prarm arr 数列
 * @return 排列后的数列
     平均时间复杂度：O(n2)
     空间复杂度：O(1)  (用于交换)
     稳定性：稳定
 */
- (NSMutableArray *)maopaoSort:(NSMutableArray *)arr orderOrDisorder:(BOOL)order;


/** 
 选择排序
 * @prarm arr 数列
 * @return 排列后的数列
 平均时间复杂度：O(n2)
 空间复杂度：O(1)  (用于交换和记录索引)
 稳定性：不稳定 （比如序列【5， 5， 3】第一趟就将第一个[5]与[3]交换，导致第一个5挪动到第二个5后面）
 */
- (NSMutableArray *)chooseSort:(NSMutableArray *)arr orderOrDisorder:(BOOL)order;


/** 不用中间变量,用两种方法交换A和B的值 */
//void swap(int a, int b);
//- (void)swapNumber:(NSInteger)a b:(NSInteger)b;

/**
 *
 求最大公约数
 *
 */
//int maxCommonDivisor(int a,int b);
#pragma mark - 扩展：最小公倍数 = (a * b)/最大公约数
@end
