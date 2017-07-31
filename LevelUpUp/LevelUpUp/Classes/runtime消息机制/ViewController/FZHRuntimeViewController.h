//
//  FZHRuntimeViewController.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZHRuntimeViewController : UIViewController
@property (nonatomic, strong) NSString  *vccc;
@end
/**
 * 函数调用，但是不接收返回值类型为结构体
    method_invoke
    函数调用，但是接收返回值类型为结构体
    method_invoke_stret
//  获取函数名
    method_getName
//  获取函数实现IMP
    method_getImplementation
//  获取函数type encoding
    method_getTypeEncoding
//  复制返回值类型
    method_copyReturnType
//  复制参数类型
    method_copyArgumentType
//  获取返回值类型
    method_getReturnType
//  获取参数个数
    method_getNumberOfArguments
//  获取函数参数类型
    method_getArgumentType
//  获取函数描述
    method_getDescription
//  设置函数实现IMP
    method_setImplementation
//  交换函数的实现IMP
    method_exchangeImplementations


 *
 */
