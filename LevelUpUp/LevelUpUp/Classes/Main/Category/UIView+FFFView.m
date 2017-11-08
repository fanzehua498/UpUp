//
//  UIView+FFFView.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/10/9.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "UIView+FFFView.h"

@implementation UIView (FFFView)

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


-(void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
@end
