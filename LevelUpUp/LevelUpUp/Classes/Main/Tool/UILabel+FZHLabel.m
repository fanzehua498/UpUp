//
//  UILabel+FZHLabel.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/5.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "UILabel+FZHLabel.h"

@implementation UILabel (FZHLabel)

-(UILabel * (^)(NSString *, UIFont *))labelText
{

    return ^UILabel* (NSString *text,UIFont *font){
        self.text = text;
        self.font = font;
        return self;
    };
}

- (UILabel *(^)(CGRect))labeFrame
{
    UILabel *(^block)(CGRect) = ^UILabel *(CGRect rect){
        self.frame = rect;
        return self;
    };
    return block;
}
@end
