//
//  FZHPerson.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FZHPerson : NSObject <NSCoding>

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString  *sex;
@property (nonatomic, assign) CGFloat myAge;

@property (nonatomic, assign) double myAge1;
@property (nonatomic, assign) CGSize mysize;

-(void)run;
+(void)classmethodRrrrrrrrr;
-(void)instanceMethodRrrrrr;
@end
