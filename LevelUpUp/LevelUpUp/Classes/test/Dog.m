//
//  Dog.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/27.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "Dog.h"

@implementation Dog
{
    NSString *toSetName;
    NSString *isName;
    NSString *_name;
    NSString *_isName;
}

//- (void)setName:(NSString *)name{
//    toSetName = name;
//}
//- (NSString*)getName{
//    return toSetName;
//}

+(BOOL)accessInstanceVariablesDirectly
{
    return NO;
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    NSLog(@"出现异常，该key不存在%@",key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    NSLog(@"出现异常，该key不存在%@ --%s",key,__func__);
}
@end
