//
//  ShapAnmaintionView.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/9/30.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "ShapAnmaintionView.h"

@implementation ShapAnmaintionView
{
    //浪高
    CGFloat _waveHeight;
    //浪宽
    CGFloat _waveWidth;
    //偏移量
    CGFloat _offsetX;
    
    //定时器
    CADisplayLink *_waveDisplayLink;
    //波浪layer
    CAShapeLayer *_waveLayer;
    
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultWithFrame:frame];
    }
    return self;
}

- (void)initDefaultWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    _waveHeight = frame.size.height/2;
    _waveWidth = frame.size.width;
    
    self.waveSpeed = 6;
    self.waveAmplitude = 6;
    self.waveColor = [UIColor blueColor];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDefaultWithFrame:self.frame];
    }
    return self;
}

- (void)wave
{
    _waveLayer = [CAShapeLayer layer];
    _waveLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:_waveLayer];
    
    _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}



- (void)getCurrentWave:(CADisplayLink *)disLink
{
    _offsetX += self.waveSpeed;
    _waveLayer.path = [self getCurrentWavePath];
}


- (CGPathRef )getCurrentWavePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, _waveHeight);
    CGFloat y = 0.0f;
    
    for (float x = 0.0f; x <= _waveWidth; x ++) {
        y = self.waveAmplitude *sinf((360 / _waveWidth) * (x * M_PI / 180) - _offsetX * M_PI / 180) +_waveHeight;
//        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, _waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    return path;
}

-(void)stop
{
    [_waveLayer removeFromSuperlayer];
    [_waveDisplayLink invalidate];
    _waveDisplayLink = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
