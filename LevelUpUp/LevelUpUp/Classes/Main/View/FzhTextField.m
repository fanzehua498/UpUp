//
//  FzhTextField.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/12.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FzhTextField.h"

@implementation FzhTextField
/**
 在调用setNeedsDisplay后，会调用drawRect方法，我们通过在此方法中可以获取到context（设置上下文），就可以实现绘图

 在调用setNeedsLayout后，会调用layoutSubviews方法，我们可以通过在此方法去调整UI。当然能引起layoutSubviews调用的方式有很多种的，比如添加子视图、滚动scrollview、修改视图的frame等。 */

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)setNeedsDisplay
{
    //会调用drawRect
}

-(void)layoutSubviews
{

}

-(void)setNeedsLayout
{
    //会调用layoutSubviews
}

//控制文本所在的的位置，左右缩 10
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 10, 0);
//}

//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 30, 0);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
