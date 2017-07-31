//
//  TwitterView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/17.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "TwitterView.h"

@implementation TwitterView
-(UIBezierPath *)setBezierPath
{
    //  这里面加入的就是刚刚PaintCode粘贴出来的代码
    UIColor* color1 = [UIColor colorWithRed: 0.521 green: 0.521 blue: 0.521 alpha: 1];

    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(552.37, 9.09)];
    [bezier2Path addCurveToPoint: CGPointMake(519.07, 26.69) controlPoint1: CGPointMake(552.37, 9.09) controlPoint2: CGPointMake(538.05, 18.98)];
    [bezier2Path addCurveToPoint: CGPointMake(480.56, 38.26) controlPoint1: CGPointMake(500.1, 34.4) controlPoint2: CGPointMake(480.56, 38.26)];
    [bezier2Path addCurveToPoint: CGPointMake(439.19, 9.09) controlPoint1: CGPointMake(480.56, 38.26) controlPoint2: CGPointMake(467.44, 22.55)];
    [bezier2Path addCurveToPoint: CGPointMake(368.15, 2.85) controlPoint1: CGPointMake(410.93, -4.38) controlPoint2: CGPointMake(368.15, 2.85)];
    [bezier2Path addCurveToPoint: CGPointMake(316.47, 30.92) controlPoint1: CGPointMake(368.15, 2.85) controlPoint2: CGPointMake(340.52, 7.85)];
    [bezier2Path addCurveToPoint: CGPointMake(281.09, 86.36) controlPoint1: CGPointMake(292.42, 53.99) controlPoint2: CGPointMake(290.08, 59.09)];
    [bezier2Path addCurveToPoint: CGPointMake(279.09, 144.27) controlPoint1: CGPointMake(272.1, 113.63) controlPoint2: CGPointMake(279.09, 144.27)];
    [bezier2Path addCurveToPoint: CGPointMake(181.55, 124.87) controlPoint1: CGPointMake(279.09, 144.27) controlPoint2: CGPointMake(224.85, 139.76)];
    [bezier2Path addCurveToPoint: CGPointMake(101.23, 83.11) controlPoint1: CGPointMake(138.25, 109.98) controlPoint2: CGPointMake(101.23, 83.11)];
    [bezier2Path addLineToPoint: CGPointMake(38.19, 22.55)];
    [bezier2Path addCurveToPoint: CGPointMake(21.56, 66.97) controlPoint1: CGPointMake(38.19, 22.55) controlPoint2: CGPointMake(24, 45.21)];
    [bezier2Path addCurveToPoint: CGPointMake(28.04, 113.2) controlPoint1: CGPointMake(19.12, 88.74) controlPoint2: CGPointMake(28.04, 113.2)];
    [bezier2Path addCurveToPoint: CGPointMake(45.34, 151.3) controlPoint1: CGPointMake(28.04, 113.2) controlPoint2: CGPointMake(34.12, 134.96)];
    [bezier2Path addCurveToPoint: CGPointMake(72.71, 178.32) controlPoint1: CGPointMake(56.55, 167.65) controlPoint2: CGPointMake(72.71, 178.32)];
    [bezier2Path addCurveToPoint: CGPointMake(45.34, 173.23) controlPoint1: CGPointMake(72.71, 178.32) controlPoint2: CGPointMake(57.6, 176.78)];
    [bezier2Path addCurveToPoint: CGPointMake(21.56, 163.51) controlPoint1: CGPointMake(33.08, 169.68) controlPoint2: CGPointMake(21.56, 163.51)];
    [bezier2Path addCurveToPoint: CGPointMake(28.04, 210.73) controlPoint1: CGPointMake(21.56, 163.51) controlPoint2: CGPointMake(20.58, 191.27)];
    [bezier2Path addCurveToPoint: CGPointMake(53.47, 246.86) controlPoint1: CGPointMake(35.49, 230.2) controlPoint2: CGPointMake(53.47, 246.86)];
    [bezier2Path addCurveToPoint: CGPointMake(80.14, 268.29) controlPoint1: CGPointMake(53.47, 246.86) controlPoint2: CGPointMake(65.25, 259.74)];
    [bezier2Path addCurveToPoint: CGPointMake(113.46, 281.28) controlPoint1: CGPointMake(95.04, 276.83) controlPoint2: CGPointMake(113.46, 281.28)];
    [bezier2Path addCurveToPoint: CGPointMake(86.11, 286.04) controlPoint1: CGPointMake(113.46, 281.28) controlPoint2: CGPointMake(98.18, 285.95)];
    [bezier2Path addCurveToPoint: CGPointMake(62.93, 281.67) controlPoint1: CGPointMake(74.03, 286.13) controlPoint2: CGPointMake(62.93, 281.67)];
    [bezier2Path addCurveToPoint: CGPointMake(80.14, 317.03) controlPoint1: CGPointMake(62.93, 281.67) controlPoint2: CGPointMake(71.12, 304.22)];
    [bezier2Path addCurveToPoint: CGPointMake(103.91, 339.84) controlPoint1: CGPointMake(89.17, 329.83) controlPoint2: CGPointMake(103.91, 339.84)];
    [bezier2Path addCurveToPoint: CGPointMake(135.88, 359.44) controlPoint1: CGPointMake(103.91, 339.84) controlPoint2: CGPointMake(119.59, 353.53)];
    [bezier2Path addCurveToPoint: CGPointMake(170.93, 364.15) controlPoint1: CGPointMake(152.16, 365.34) controlPoint2: CGPointMake(170.93, 364.15)];
    [bezier2Path addCurveToPoint: CGPointMake(135.88, 386.44) controlPoint1: CGPointMake(170.93, 364.15) controlPoint2: CGPointMake(153.54, 376.98)];
    [bezier2Path addCurveToPoint: CGPointMake(101.13, 401.54) controlPoint1: CGPointMake(118.21, 395.9) controlPoint2: CGPointMake(101.13, 401.54)];
    [bezier2Path addCurveToPoint: CGPointMake(53.47, 412.64) controlPoint1: CGPointMake(101.13, 401.54) controlPoint2: CGPointMake(81.16, 409.59)];
    [bezier2Path addCurveToPoint: CGPointMake(0.29, 412.64) controlPoint1: CGPointMake(25.78, 415.7) controlPoint2: CGPointMake(0.29, 412.64)];
    [bezier2Path addCurveToPoint: CGPointMake(72.71, 447.67) controlPoint1: CGPointMake(0.29, 412.64) controlPoint2: CGPointMake(36.62, 435.16)];
    [bezier2Path addCurveToPoint: CGPointMake(149.39, 464.31) controlPoint1: CGPointMake(108.8, 460.17) controlPoint2: CGPointMake(149.39, 464.31)];
    [bezier2Path addCurveToPoint: CGPointMake(249.01, 457.71) controlPoint1: CGPointMake(149.39, 464.31) controlPoint2: CGPointMake(196.6, 469.56)];
    [bezier2Path addCurveToPoint: CGPointMake(352.07, 418.46) controlPoint1: CGPointMake(301.42, 445.86) controlPoint2: CGPointMake(352.07, 418.46)];
    [bezier2Path addCurveToPoint: CGPointMake(414.45, 370.11) controlPoint1: CGPointMake(352.07, 418.46) controlPoint2: CGPointMake(388.26, 396.31)];
    [bezier2Path addCurveToPoint: CGPointMake(458.34, 312.2) controlPoint1: CGPointMake(440.64, 343.92) controlPoint2: CGPointMake(458.34, 312.2)];
    [bezier2Path addCurveToPoint: CGPointMake(489.68, 246.86) controlPoint1: CGPointMake(458.34, 312.2) controlPoint2: CGPointMake(476.64, 284.33)];
    [bezier2Path addCurveToPoint: CGPointMake(509.39, 165.55) controlPoint1: CGPointMake(502.73, 209.38) controlPoint2: CGPointMake(509.39, 165.55)];
    [bezier2Path addLineToPoint: CGPointMake(510.48, 117.41)];
    [bezier2Path addCurveToPoint: CGPointMake(542.8, 90.45) controlPoint1: CGPointMake(510.48, 117.41) controlPoint2: CGPointMake(526.7, 107.34)];
    [bezier2Path addCurveToPoint: CGPointMake(569.12, 56.54) controlPoint1: CGPointMake(558.9, 73.55) controlPoint2: CGPointMake(569.12, 56.54)];
    [bezier2Path addLineToPoint: CGPointMake(537.79, 66.97)];
    [bezier2Path addLineToPoint: CGPointMake(503.61, 73.55)];
    [bezier2Path addCurveToPoint: CGPointMake(537.79, 43.14) controlPoint1: CGPointMake(503.61, 73.55) controlPoint2: CGPointMake(528.94, 56.27)];
    [bezier2Path addCurveToPoint: CGPointMake(552.37, 9.09) controlPoint1: CGPointMake(546.63, 30.01) controlPoint2: CGPointMake(552.37, 9.09)];
    [bezier2Path closePath];
    bezier2Path.miterLimit = 4;

    bezier2Path.usesEvenOddFillRule = YES;

    [color1 setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    return bezier2Path;
}
-(void)addLayerToLaunchView
{
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = [self setBezierPath].CGPath;
    layer.bounds = CGPathGetBoundingBox(layer.path);

    self.backgroundColor = [UIColor blueColor];
    layer.position = CGPointMake(self.layer.bounds.size.width / 2, self.layer.bounds.size.height/ 2);
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
