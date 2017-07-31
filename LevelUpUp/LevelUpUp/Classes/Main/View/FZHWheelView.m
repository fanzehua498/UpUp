//
//  FZHWheelView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/16.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHWheelView.h"

@interface FZHWheelView ()
{
    //背景view
    UIView *_baseView;

    BOOL aniBool;

    int _index;
}
@end

@implementation FZHWheelView

-(instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    if (frame.size.height > 0) {

        if (_baseView == nil) {
            //初始化视图
            _baseView = [[UIView alloc] init];
        }

    }
}



@end
