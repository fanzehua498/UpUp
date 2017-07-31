//
//  NSObject+FZHRunTimeTool.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "NSObject+FZHRunTimeTool.h"
#import <objc/runtime.h>
@implementation NSObject (FZHRunTimeTool)

+(NSString *)fzh_fetchClassName:(Class)class
{
    //获取c类型的类名
    const char *className =  class_getName(class);
    //转换为oc的类名
    return [NSString stringWithUTF8String:className];
}


+(NSArray *)fzh_fetchClassAllPropertyName:(Class)class
{
    unsigned int outCount = 0;
    objc_property_t *pros = class_copyPropertyList(class, &outCount);
    NSMutableArray *proArray = [NSMutableArray array];
    for (int i = 0; i < outCount; i ++) {
        objc_property_t pro = pros[i];
        const char *cProName = property_getName(pro);
        NSString *ocProName = [NSString stringWithUTF8String:cProName];
        [proArray addObject:ocProName];
    }
    //手动释放
    free(pros);
    return [NSArray arrayWithArray:proArray];
}

+(NSArray *)fzh_fetchClassAllPropertyWithTypeName:(Class)class
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(class, &count);

    NSMutableArray *propretyArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        //runtime描述的成员变量
        Ivar ivar = ivars[i];
        const char *name1 = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeOc = [NSString stringWithUTF8String:type];
        NSString *key = [NSString stringWithUTF8String:name1];

        //kvc取出value
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        /** 动态获取到的是q字母，其实是NSInteger的符号。而i就表示int类型，c表示Bool类型，d表示double类型，f则就表示float类型 */
        if ([typeOc isEqualToString:@"q"]) {
            typeOc = @"NSInteger";
        }else if ([typeOc isEqualToString:@"i"]){
            typeOc = @"int";
        }else if ([typeOc isEqualToString:@"c"]){
            typeOc = @"Bool";
        }else if ([typeOc isEqualToString:@"d"]){
            typeOc = @"double";
        }else if ([typeOc isEqualToString:@"f"]){
            typeOc = @"float";
        }else{
            //就按原来的显示
        }

        [dict setValue:typeOc forKey:@"type"];
        [dict setValue:key forKey:@"proprety"];
        [propretyArray addObject:dict];
    }
    //ivars不归arc管理 需要释放
    //c语言中一旦遇到copy、create、new需要释放
    free(ivars);

    return [NSArray arrayWithArray:propretyArray];
}

+(NSArray *)fzh_fetchMethodList:(Class)class
{
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(class, &outCount);

    NSMutableArray *methodArray = [NSMutableArray array];
    for (int i = 0; i < outCount; i ++) {
        Method method = methods[i];
        SEL methodName = method_getName(method);
        NSString *name = NSStringFromSelector(methodName);
        [methodArray addObject:name];
    }
    return [NSArray arrayWithArray:methodArray];
}

+(NSArray *)fzh_fetchClassProtocolList:(Class)class
{
    unsigned int outCount = 0;
    __unsafe_unretained Protocol **protocols = class_copyProtocolList(class, &outCount);
    NSMutableArray *protocalArray = [NSMutableArray array];
    for (int i = 0; i < outCount; i ++) {
        Protocol *protocal = protocols[i];
        const char *protocolName = protocol_getName(protocal);
        NSString *ocProtocolName = [NSString stringWithUTF8String:protocolName];
        [protocalArray addObject:ocProtocolName];
    }
    return [NSArray arrayWithArray:protocalArray];
}

+(BOOL)fzh_addMethod:(Class)class method:(SEL)methodSel methodName:(SEL)methodNameSelImp
{
    Method method = class_getInstanceMethod(class, methodNameSelImp);
    IMP methodImp = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    return  class_addMethod(class, methodSel, methodImp, types);
}

+(void)fzh_medthodExchange:(Class)class methodOne:(SEL)methodOne methodTwo:(SEL)methodTwo
{
    Method m1 = class_getInstanceMethod(class, methodOne);
    Method m2 = class_getInstanceMethod(class, methodTwo);
    method_exchangeImplementations(m1, m2);
}

/**
 *  getter 方法
 *  @return 设返回关联的值
 */
-(NSString *)relatedProperty
{
    return objc_getAssociatedObject(self, "relatedProperty");
}

/**
 *  setter 方法
 *  @param relatedProperty 设置关联的值
 */
-(void)setRelatedProperty:(NSString *)relatedProperty
{
    objc_setAssociatedObject(self, "relatedProperty", relatedProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
