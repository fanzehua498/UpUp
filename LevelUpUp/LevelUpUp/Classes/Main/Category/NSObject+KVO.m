//
//  NSObject+KVO.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "NSObject+KVO.h"
#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface NSObject ()
{
//    id _theClass;
}
@end

@implementation NSObject (KVO)

-(void)Fzh_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
//    _theClass = [self class];
    //1,动态添加一个类 objc_allocateClassPair
    NSString *oldClassName = NSStringFromClass([self class]);
    NSLog(@"oldClassName:%@",oldClassName);
    NSString *newName = [@"FZHKVO_" stringByAppendingString:oldClassName];
    NSLog(@"newName%@",newName);
    const char *new = newName.UTF8String;

    //2，定义一个类
     Class _myclass = objc_allocateClassPair([self class], new, 0);
    NSLog(@"class:%@",NSStringFromClass([self class]));
#warning 自己的想法
    //获取实现方法名
    NSString *upKeyPath = [[keyPath substringToIndex:1].uppercaseString stringByAppendingString:[keyPath substringFromIndex:1]];

    NSString *fzh_method = [@"set" stringByAppendingString:upKeyPath];
    const char * c_method = fzh_method.UTF8String;

    SEL selName = NSSelectorFromString([NSString stringWithFormat:@"%@:",fzh_method]);

    //重写set方法(动态添加方法)
    class_addMethod(_myclass, selName, (IMP)fzh_setter, "v@:@");
    //3，注册这个类
    objc_registerClassPair(_myclass);
    //4，改变isa指针
    object_setClass(self, _myclass);
    NSLog(@"class:%@",NSStringFromClass([self class]));
    //动态绑定属性
//    const void *key = "age";
    objc_setAssociatedObject(self, keyPath.UTF8String, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    
}

-(void)Fzh_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    NSString *oldClassName = NSStringFromClass([self class]);
//    objc_associa
    oldClassName = [oldClassName substringFromIndex:7];
    Class a = NSClassFromString(oldClassName);
//    NSClassFromString(<#NSString * _Nonnull aClassName#>)
    //注销这个类
    objc_disposeClassPair([self class]);
    //需要将isa指针改回来
    object_setClass(self, a);
//    objc_removeAssociatedObjects(self);
}

const void *key = "age";
void fzh_setter(id self,SEL _cmd,id obj){
//    保存当前类型
    id class = [self class];
    //改变当前对象指向父类 （让自己指向父类）
    object_setClass(self, class_getSuperclass(class));

//    id superclass = [self class];
    NSString *keyPath = NSStringFromSelector(_cmd);
    keyPath = [keyPath substringWithRange:NSMakeRange(3, keyPath.length - 4)].lowercaseString;
//    SEL selName = NSSelectorFromString([NSString stringWithFormat:@"%@:",_cmd]);
    //调用父类的setName方法
    objc_msgSend(self,_cmd,obj);
    NSLog(@"laile");
    //拿出观察者
    id observer = objc_getAssociatedObject(self, key);
    //通知外界
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),keyPath,keyPath,@{@"new":obj},nil);
    //改回原对象
    object_setClass(self, class);
}

@end
