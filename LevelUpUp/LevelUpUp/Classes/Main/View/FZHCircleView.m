//
//  FZHCircleView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/5/22.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHCircleView.h"

#define kLineWidth 2
@interface FZHCircleView ()

@property (nonatomic, strong) UIImageView  *imageView;

@property (nonatomic, strong) CAShapeLayer  *outLayer;
@property (nonatomic, strong) CAShapeLayer  *progressLayer;
@end

@implementation FZHCircleView

-(void)setImageUrl:(NSString *)url
{
//    创建图片：
    CGRect frame = self.frame;
    self.layer.cornerRadius = frame.size.width / 2;
    self.layer.masksToBounds = YES;
    self.imageView.image = [UIImage imageNamed:url];
    [self addSubview:self.imageView];

//    第一步：添加灰色圆环
    self.outLayer = [CAShapeLayer layer];
    CGRect rect = {kLineWidth / 2, kLineWidth / 2,
        frame.size.width - kLineWidth, frame.size.height - kLineWidth};
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    self.outLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.outLayer.lineWidth = kLineWidth;
    self.outLayer.fillColor =  [UIColor clearColor].CGColor;
    self.outLayer.lineCap = kCALineCapRound;
    self.outLayer.path = path.CGPath;
    [self.layer addSublayer:self.outLayer];

    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor blueColor].CGColor;
    self.progressLayer.lineWidth = kLineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.path = path.CGPath;
    [self.layer addSublayer:self.progressLayer];
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
}

- (void)updateProgressWithNumber:(NSInteger)progress
{
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.progressLayer.strokeEnd =  progress / 100.0;
    [CATransaction commit];
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
