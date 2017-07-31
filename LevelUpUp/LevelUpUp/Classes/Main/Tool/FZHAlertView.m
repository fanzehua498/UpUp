//
//  FZHAlertView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/5.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHAlertView.h"

@implementation FZHAlertView

-(FZHAlertView *(^)())eat:(NSString *)text
{
    return ^ {
        self.text = text;
        return self;
    };
}

-(FZHAlertView *(^)())run:(NSString *)text
{
    return ^ {
        self.placeholder = text;
        return self;
    };
}


-(FZHAlertView *(^)())show:(UIColor *)color
{
    return ^{
        self.textColor = color;
        return self;
    };
}

- (AlertBlock )begin
{
    FZHAlertView*  (^block)() = ^FZHAlertView* (NSString *text){
        NSLog(@"begin");
        self.text = text;
        return self;
    };
    return block;
//    return ^FZHAlertView* (){
//
//        NSLog(@"begin");
//        return self;
//    };
//    return AlertEatBlock;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
