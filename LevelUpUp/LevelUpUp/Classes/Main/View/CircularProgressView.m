//
//  CircularProgressView.m
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//  QQ:20118368
//  http://nijino_saki.blog.163.com

#import "CircularProgressView.h"

@interface CircularProgressView ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) UIColor *backColor;
@property (strong, nonatomic) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) float progress;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
       processValue:(double)value
              style:(NSString *)style
{
    self = [super initWithFrame:frame];
    if (self) {

        self.style = style;
        self.backgroundColor = [UIColor clearColor];
        _backColor = backColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;

        self.processValue = value;
        
        if([self.style isEqualToString:@"one"])
        {
            centerLabel = [[UILabel alloc]initWithFrame:CGRectMake( 9, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
            centerLabel.textAlignment = NSTextAlignmentCenter;
            centerLabel.textColor = progressColor;
            centerLabel.font = [UIFont systemFontOfSize:25];
            centerLabel.text = @"0";
            [self addSubview:centerLabel];
            
            perLabel = [[UILabel alloc]initWithFrame:CGRectMake(42, 24, self.bounds.size.width-50, self.bounds.size.width-55)];
            perLabel.textAlignment = NSTextAlignmentLeft;
            perLabel.textColor = progressColor;
            perLabel.font = [UIFont systemFontOfSize:12];
            perLabel.text = @"%";
            [self addSubview:perLabel];
            
//            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, self.bounds.size.width, 20)];
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            titleLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.9];
//            titleLabel.font = [UIFont systemFontOfSize:11];
//            titleLabel.text = @"当前进度";
//            [self addSubview:titleLabel];
        }
        else if ([self.style isEqualToString:@"two"])
        {
            self.timeDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.bounds.size.width, 20)];
            self.timeDownLabel.textAlignment = NSTextAlignmentCenter;
            self.timeDownLabel.textColor = [UIColor whiteColor];
            self.timeDownLabel.font = [UIFont systemFontOfSize:19];
            self.timeDownLabel.text = @"--:--:--";
            [self addSubview:self.timeDownLabel];
            
//            kaibiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 19, self.bounds.size.width, 30)];
//            kaibiaoLabel.textAlignment = NSTextAlignmentCenter;
//            kaibiaoLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];//[UIColor colorWithRed:1.0 green:0.3 blue:0.3 alpha:1.0];
//            kaibiaoLabel.font = [UIFont systemFontOfSize:14.5];
//            kaibiaoLabel.text = @"距离开标";
//            [self addSubview:kaibiaoLabel];
        }
        else if ([self.style isEqualToString:@"three"])
        {
            centerLabel = [[UILabel alloc]initWithFrame:CGRectMake( 0, 8, self.bounds.size.width, self.bounds.size.width-16)];
            centerLabel.textAlignment = NSTextAlignmentCenter;
            centerLabel.textColor = progressColor;
            centerLabel.font = [UIFont boldSystemFontOfSize:15];
            centerLabel.text = @"0.00%";
            [self addSubview:centerLabel];
            
        }
        else if([self.style isEqualToString:@"four"])
        {
            self.daysLabel = [[UILabel alloc]initWithFrame:CGRectMake( 5, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
            self.daysLabel.textAlignment = NSTextAlignmentCenter;
            self.daysLabel.textColor = progressColor;
            self.daysLabel.font = [UIFont systemFontOfSize:25];
            self.daysLabel.text = @"--";
            [self addSubview:self.daysLabel];
            
            dayAfter = [[UILabel alloc]initWithFrame:CGRectMake(47, 23, self.bounds.size.width-50, self.bounds.size.width-55)];
            dayAfter.textAlignment = NSTextAlignmentLeft;
            dayAfter.textColor = progressColor;
            dayAfter.font = [UIFont systemFontOfSize:13];
            dayAfter.text = @"天后";
            [self addSubview:dayAfter];
            
            titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, self.bounds.size.width, 20)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.9];
            titleLabel.font = [UIFont systemFontOfSize:11];
            titleLabel.text = @"自动到账";
            [self addSubview:titleLabel];
        }

    }
    
    return self;
}

-(void)setprocessValue:(double)processValue
{
    if ([self.style isEqualToString:@"one"]) {
        self.processValue = processValue;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    else if ([self.style isEqualToString:@"two"])
    {
        self.progress = processValue;
        [self setNeedsDisplay];
    }
    else if ([self.style isEqualToString:@"three"])
    {
        self.processValue = processValue;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    else if ([self.style isEqualToString:@"four"])
    {
        self.progress = processValue;
        [self setNeedsDisplay];
        
        if ([self.daysLabel.text integerValue]>=10) {
            [self.daysLabel setFrame:CGRectMake( 3.5, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
            [dayAfter setFrame:CGRectMake(43.5, 23, self.bounds.size.width-50, self.bounds.size.width-55)];
        }
        else if ([self.daysLabel.text integerValue]<10)
        {
            [self.daysLabel setFrame:CGRectMake( 2, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
            [dayAfter setFrame:CGRectMake(35, 23, self.bounds.size.width-50, self.bounds.size.width-55)];
        }
    }

}

- (void)drawRect:(CGRect)rect
{
    //draw background circle
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                              radius:self.bounds.size.width / 2 - self.lineWidth / 2
                                                          startAngle:(CGFloat) - M_PI_2
                                                            endAngle:(CGFloat)(1.5 * M_PI)
                                                           clockwise:YES];
    [self.backColor setStroke];
    backCircle.lineWidth = self.lineWidth;
    [backCircle stroke];
    
    if (self.progress != 0) {
        //draw progress circle
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                                      radius:self.bounds.size.width / 2 - self.lineWidth / 2
                                                                  startAngle:(CGFloat) - M_PI_2
                                                                    endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI)
                                                                   clockwise:YES];
        [self.progressColor setStroke];
        progressCircle.lineWidth = self.lineWidth;
        [progressCircle stroke];
    }
}

- (void)updateProgressCircle{
    //update progress value
    
    if (self.processValue == 0) {
        self.progress = 0;
        if ([self.style isEqualToString:@"one"]) {
            centerLabel.text = @"0";
        }
        else
        {
            centerLabel.text = @"0.00%";
        }
       
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        if (self.progress < self.processValue/100.0) {
            self.progress = self.progress+0.0101;
            if ([self.style isEqualToString:@"one"]) {
                centerLabel.text = [NSString stringWithFormat:@"%.0f ",self.progress*100];
                
                if (self.progress<0.1) {
                    [perLabel setFrame:CGRectMake( 42, 24, self.bounds.size.width-50, self.bounds.size.width-55)];
                    [centerLabel setFrame:CGRectMake( 9, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
                }
                else
                {
                    [perLabel setFrame:CGRectMake( (self.progress>=1.0)?55:50, 24, self.bounds.size.width-50, self.bounds.size.width-55)];
                    [centerLabel setFrame:CGRectMake( (self.progress>=1.0)?9:10, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
                }
            }
            else
            {
                centerLabel.text = [NSString stringWithFormat:@"%.2f%%",self.progress*100];
            }
            
        }
        else
        {
            if ([self.style isEqualToString:@"one"]) {
                centerLabel.text = [NSString stringWithFormat:@"%.0f ",self.processValue];
                
                if (self.progress<0.1) {
                    [perLabel setFrame:CGRectMake( 42, 24, self.bounds.size.width-50, self.bounds.size.width-55)];
                    [centerLabel setFrame:CGRectMake( 9, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
                }
                else
                {
                    [perLabel setFrame:CGRectMake( (self.progress>=1.0)?55:50, 24, self.bounds.size.width-50, self.bounds.size.width-55)];
                    [centerLabel setFrame:CGRectMake( (self.progress>=1.0)?9:10, 0, self.bounds.size.width-30, self.bounds.size.width-16)];
                }
            }
            else
            {
                if (self.progress < self.processValue/100.0) {
                    self.progress = self.progress+0.0101;
                    centerLabel.text = [NSString stringWithFormat:@"%.2f%%",self.progress*100];
                }
                else
                {
                    centerLabel.text = [NSString stringWithFormat:@"%.2f%%",self.processValue];
                }
            }
            
            //self.progress = self.processValue;
            [self.timer invalidate];
            self.timer = nil;
        }

    }
    
    [self setNeedsDisplay];
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)]) {
        [self.delegate didUpdateProgressView];
    }
}

@end
