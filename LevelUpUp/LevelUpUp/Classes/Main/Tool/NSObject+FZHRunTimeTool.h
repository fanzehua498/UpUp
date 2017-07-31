//
//  NSObject+FZHRunTimeTool.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//
/**
 + (BOOL)resolveClassMethod:(SEL)sel;
 + (BOOL)resolveInstanceMethod:(SEL)sel;
 //后两个方法需要转发到其他的类处理
 - (id)forwardingTargetForSelector:(SEL)aSelector;
 - (void)forwardInvocation:(NSInvocation *)anInvocation;
 */
#import <Foundation/Foundation.h>

@interface NSObject (FZHRunTimeTool)

/**
 *  获取类名
 *  @param class 对应类
 *  @return NSString：类名
 */
+ (NSString *)fzh_fetchClassName:(Class)class;

/**
 *  获取类中所有成员变量
 *  @param class 对应类
 *  @return NSArray：类属性数组(不含数据类型)
 */
+ (NSArray *)fzh_fetchClassAllPropertyName:(Class)class;

/**
 *  获取类中所有成员变量
 *  @param class 对应类
 *  @return NSArray：类属性数组(含属性类型)
 */
+ (NSArray *)fzh_fetchClassAllPropertyWithTypeName:(Class)class;

/**
 *  获取类的实例方法列表：setter，getter，只能获取对像方法。不能获取类方法
 *  @param class 对应类
 *  @return NSArray：
 */
+ (NSArray *)fzh_fetchMethodList:(Class)class;

/**
 *  获取协议列表
 *  @param class 对应类
 *  @return NSArray：协议数组
 */
+ (NSArray *)fzh_fetchClassProtocolList:(Class)class;

/**
 *  动态添加新的方法
 *  @param class 对应类
 *  @param methodSel 添加的方法名
 *  @param methodNameSelImp 对应方法实现的方法名
 */

//测试发现 当动态添加的新方法只有在调用的类和此类中 才可调用到
+ (BOOL)fzh_addMethod:(Class)class method:(SEL)methodSel methodName:(SEL)methodNameSelImp;

/**
 *  方法交换（hook）
 *  @param class 对应类
 *  @param methodOne 方法1
 *  @param methodTwo 方法2
 */
+ (void)fzh_medthodExchange:(Class)class methodOne:(SEL)methodOne methodTwo:(SEL)methodTwo;

/**
 *  runtime 动态属性关联
 *
 */
@property (nonatomic, strong) NSString  *relatedProperty;

@property (nonatomic, strong) NSString  *myrelatedProperty;
@end
