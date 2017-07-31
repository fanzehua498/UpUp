//
//  FZHCreateClasOrMethod.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHCreateClasOrMethod.h"
#import <objc/message.h>

//objc _cmd默认参数
//obj 自己的参数
void eat(id objc,SEL _cmd,id obj){
    NSLog(@"eat%@",obj);
}

@implementation FZHCreateClasOrMethod

//调用了一个没有实现的对象方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{

    //添加一个未实现方法
    //IMP 方法实现 就是一个函数指针
    //type:返回值类型
    if (sel == @selector(eat:)) {
        class_addMethod([FZHCreateClasOrMethod class], @selector(eat:), (IMP)eat, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}
//调用一个没有实现的类方法
+(BOOL)resolveClassMethod:(SEL)sel
{
    return  [super resolveClassMethod:sel];
}

@end
