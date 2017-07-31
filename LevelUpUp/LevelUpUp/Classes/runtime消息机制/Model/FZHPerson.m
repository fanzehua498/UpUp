//
//  FZHPerson.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHPerson.h"
#import <objc/message.h>
@implementation FZHPerson

+(void)classmethodRrrrrrrrr
{
    NSLog(@"+++");
}

-(void)instanceMethodRrrrrr
{
    NSLog(@"");
}

-(void)run
{
    NSLog(@"running");
}

/**
    class_copyIvarList（）返回一个指向类的成员变量数组的指针
    class_copyPropertyList（）返回一个指向类的属性数组的指针
 */
//归档  哪些属性
-(void)encodeWithCoder:(NSCoder *)aCoder
{
//    [aCoder encodeObject:_name forKey:@"name"];
//    [aCoder encodeInteger:_age forKey:@"age"];

//    for (int i = 0; i < 属性数组个数; i++) {
//        属性 = 属性数组[i];
//    }
    //成员变量个数
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([FZHPerson class], &count);
    for (int i = 0; i < count; i ++) {
        //runtime描述的成员变量
        Ivar ivar = ivars[i];
        const char *name1 = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *typeOc = [NSString stringWithUTF8String:type];
        NSString *key = [NSString stringWithUTF8String:name1];

        //kvc取出value
        NSString *nameValue = [self valueForKey:key];
//        NSLog(@"%s %@ %@ %@",name1,key,nameValue,typeOc);
        [aCoder encodeObject:nameValue forKey:key];
    }
    //ivars不归arc管理 需要释放
    //c语言中一旦遇到copy、create、new需要释放
    free(ivars);

    //属性
    unsigned int outCount = 0;
    objc_property_t *pros = class_copyPropertyList([FZHPerson class], &outCount);
//    NSLog(@"%d",outCount);
    for (int j = 0; j<outCount; j++) {
        objc_property_t p = pros[j];
        const char *proName = property_getName(p);
        NSString *ocName = [NSString stringWithUTF8String:proName];
//        NSLog(@"%@",ocName);
    }
    free(pros);

    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList([FZHPerson class], &methodCount);
    for (int k = 0; k < methodCount; k ++) {
        Method method = methods[k];
        SEL name = method_getName(method);
        NSLog(@"%@",NSStringFromSelector(name));
    }
    
}
//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init]) {
        //成员变量个数
        unsigned int count = 0;

        Ivar *ivars = class_copyIvarList([FZHPerson class], &count);
        for (int i = 0; i < count; i ++) {
            //runtime描述的成员变量
            Ivar ivar = ivars[i];
            const char *name1 = ivar_getName(ivar);
//            NSLog(@"%s",name1);
            NSString *key = [NSString stringWithUTF8String:name1];

            id value = [aDecoder decodeObjectForKey:key];
            //必须kvc 设置。否则会报错
            [self setValue:value forKey:key];

        }
        //ivars不归arc管理 需要释放
        //c语言中一旦遇到copy、create、new需要释放
        free(ivars);
//        _name = [aDecoder decodeObjectForKey:@"name"];
//        _age = [aDecoder decodeIntegerForKey:@"age"];


    }
    return self;
}
-(void)setName:(NSString *)name
{
    _name = name;
//    [name setValue:@"" forKey:@""];
//    [[NSObject alloc]init] setob
}
@end
