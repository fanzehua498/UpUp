//
//  FZHFunction.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/14.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHFunction.h"
//保护全局变量：在全局变量前加static后，这个全局变量就只能在本文件中使用
static int data[1024];//栈最多能保存1024个数据
static int count = 0;//目前已经放了多少个数(相当于栈顶位置)
@interface FZHFunction ()

@end

@implementation FZHFunction

- (int)halfFunctionIntArr:(NSArray *)a number:(int) number
{
    if (a.count == 0) {
        return -1;
    }
    int start = 0;
    int index = 0;
    int end = (int)a.count - 1;
    while (start + 1 < end) {
        index = start + (end - start)/2;
        if ([a[index] intValue] == number) {
            return index;
        }else if ([a[index] intValue] < number){
            start = index ;
        }else{
            end = index ;
        }

    }
    if ([a[start] intValue] == number) {
        return start;
    }
    if ([a[end] intValue] == number) {
        return end;
    }

    return index;
}

-(NSMutableArray *)maopaoSort:(NSMutableArray *)arr orderOrDisorder:(BOOL)order
{
    for (int i = 0; i < arr.count - 1; i++) {
        for (int j =0; j <arr.count - 1 - i; j ++) {
            if (order) {
                if (arr[j] > arr[j+1]) {
                    id temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp;
                }

            } else {
                if (arr[j] < arr[j+1]) {
                    id temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp;
                }

            }

        }
    }

    return arr;
}

-(NSMutableArray *)chooseSort:(NSMutableArray *)arr orderOrDisorder:(BOOL)order
{
    for (int i = 0; i < arr.count-1; i++) {
        for (int j = i+1; j<arr.count; j++) {
            if (order) {
                if(arr[i]>arr[j]){
                    id temp = arr[j];
                    arr[j] = arr[i];
                    arr[i] = temp;
                }

            }else{
                if(arr[i]<arr[j]){
                    id temp = arr[j];
                    arr[j] = arr[i];
                    arr[i] = temp;
                }

            }
        }
    }

    return arr;
}

//int halfFuntion(int a[], int length, int number)
//{
//    int start = 0;
//    int end = length - 1;
//    int index = 0;
//    while(start < end)
//    {
//        index = start + (end - start)/2;
//        if(a[index] == number){
//            return index;
//        } else if(a[index] < number){
//            start = index + 1;
//        } else{
//            end = index - 1;
//        }
//    }
//    return index;
//}


#pragma  mark - 不用中间变量,用两种方法交换A和B的值
//// 2.加法(举一)
//void swapOne(int a, int b){
//    a = a+b;
//    b = a - b;
//    a = a - b;
//}
//// 3.异或（相同为0，不同为1. 可以理解为不进位加法）
//void swapTwo(int a, int b){
//    a = a^b;
//    b = a^b;
//    a = a^b;
//}
//
//#pragma  mark - 求最大公约数
///** 1.直接遍历法 */
//int maxCommonDivisor(int a,int b){
//    int max = 0;
//    for (int i = 0; i <= b; i++) {
//        if (a%i == 0 && b%i == 0) {
//            max = i;
//        }
//    }
//    return max;
//}
//
///** 2.辗转相除法 */
//int maxCommonDivisorTwo(int a, int b){
//    int r ;
//    a = a>b ? a:b;
//    while (a%b > 0) {
//        r = a%b;
//        a = b;
//        b = r;
//    }
//    return b;
//}
//
//#pragma mark - 模拟栈操作
////数据入栈 push
//void Push(int x){
//    assert(!full());//防止数组越界
//    data[count ++] = x;
//}
//
////数据出栈 pop
//int pop(){
//    assert(!empty());
//    return data[count --];
//}
//
////查看栈顶元素 top
//int top(){
//    assert(!empty());
//    return data[count - 1];
//}
//
////查询栈满 full
//bool full(){
//    if (count >=1024) {
//        return 1;
//    }
//    return 0;
//}
////查询栈空 empty
//bool empty() {
//    if(count <= 0) {
//        return 1;
//    }
//    return 0;
//}
//
//int main(){
//    //入栈
//    for (int i = 1; i <= 10; i++) {
//        Push(i);
//    }
//
//    //出栈
//    while(!empty()){
//        printf("%d ", top()); //栈顶元素
//        pop(); //出栈
//    }
//    printf("\n");
//
//    return 0;
//}


@end
