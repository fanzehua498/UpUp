//
//  KnowledgePoint.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/27.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct FzhStruct{
    int a;
    int b;
} *my_struct;

@interface KnowledgePoint : NSObject

@property (nonatomic, assign) my_struct arg3;

@property (nonatomic, copy) NSString *arg1;
@property (nonatomic, copy) NSString *arg2;

@end
