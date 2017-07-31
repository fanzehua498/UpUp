//
//  FZHAnimationLable.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/3/30.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHAnimationLable.h"

@interface FZHAnimationLable ()<CAAnimationDelegate>
{
    //是否初始化过了
    BOOL _seted;
    //移动
    BOOL _moveNeed;
    //label速度
    CGFloat _rate;
    CGRect _fRect;
}
/** <#type#> */
@property (nonatomic, strong) UIView  *innerContainer;

@end

@implementation FZHAnimationLable

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.font = [UIFont systemFontOfSize:12];
    self.textColor = [UIColor blackColor];
    self.speed = FZHSpeedMid;
    self.repeatCount = 0;
    self.leastDistens = 10.0f;
    self.clipsToBounds = YES;
    _rate = 80.f;
    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:12];
        self.textColor = [UIColor blackColor];
        self.speed = FZHSpeedMid;
        self.repeatCount = 0;
        self.leastDistens = 10.0f;
        self.clipsToBounds = YES;
        [self setUp];
    }
    return self;
}

-(void)setSpeed:(FZHSpeed)speed
{
    _speed = speed;
    switch (speed) {
        case FZHSpeedMid:
            _rate = 75;
            break;
        case FZHSpeedSlow:
            _rate = 40;
            break;
        case FZHSpeedFast:
            _rate = 90;
            break;

        default:
            break;
    }
    [self reloadView];
}

- (void)setLeastDistens:(CGFloat)leastDistens
{
    _leastDistens = leastDistens;

    [self reloadView];
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    [self reloadView];
}
-(void)setText:(NSString *)text
{
    _text = text;
    _attributedString = nil;
    [self reloadView];
}
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self reloadView];
}
-(void)setAttributedString:(NSAttributedString *)attributedString
{
    _attributedString = [self setAttributedTextDefaultFont:attributedString];
    _text = nil;
    [self reloadView];
}

- (NSAttributedString *)setAttributedTextDefaultFont:(NSAttributedString *)attributedString
{
    NSMutableAttributedString *defaultString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];

    void (^enmuerateBlock)(id,NSRange,BOOL *) = ^(id value,NSRange range,BOOL *stop){

        if (!value ||[value isKindOfClass:[NSNull class]]) {
            [defaultString addAttribute:NSFontAttributeName value:self.font range:range];
        }
    };

    [defaultString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, defaultString.string.length) options:NSAttributedStringEnumerationReverse usingBlock:enmuerateBlock];
    return defaultString;
}


- (void)setUp{
    if (_seted) {
        return;
    }
    self.innerContainer = [[UIView alloc] initWithFrame:self.bounds];
    self.innerContainer.backgroundColor = [UIColor clearColor];
    self.innerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.innerContainer];
    _seted = YES;
}

- (void)reloadView
{
    [self.innerContainer.layer removeAnimationForKey:@"move"];
    for (UIView *sub in self.innerContainer.subviews) {
        if ([sub isKindOfClass:[UILabel class]]) {
            [sub removeFromSuperview];
        }
    }

    CGFloat width = [self evaluateContentWidth];
    _moveNeed = width > self.bounds.size.width;

    _fRect = CGRectMake(0, 0, width, self.bounds.size.height);
    if (width < self.bounds.size.width) {
        _fRect = self.bounds;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:_fRect];
    label.backgroundColor = [UIColor clearColor];
    if (self.text) {
        label.text = self.text;
        label.textColor = self.textColor;
        label.font = self.font;
    }else{
        label.attributedText = self.attributedString;
    }
    [self.innerContainer addSubview:label];
    if (_moveNeed) {

        CGRect Labelrect2 = CGRectMake(width + self.leastDistens, 0, width, self.bounds.size.height);
        UILabel *next = [[UILabel alloc] initWithFrame:Labelrect2];
        if (self.text) {
            next.text = self.text;
            next.textColor = self.textColor;
            next.font = self.font;
        }else{
            next.attributedText = self.attributedString;
        }
        [self.innerContainer addSubview:next];
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        /**
         *
         *values:就是上述的NSArray对象。里面的元素称为”关键帧”(keyframe)。动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧

         * path：可以设置一个CGPathRef\CGMutablePathRef,让层跟着路径移动。path只对CALayer的anchorPoint和position起作用。如果你设置了path，那么values将被忽略
         * keyTimes：可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
         */
//        moveAnimation.keyTimes = @[@0.,@0.2,@0.4,@1.0];
        moveAnimation.duration = width / _rate;
        NSLog(@"%f",width / _rate);
//        moveAnimation.duration = 100;
        moveAnimation.values = @[@0,@0.,@(- width - self.leastDistens)];

        moveAnimation.repeatCount = self.repeatCount == 0 ? INT16_MAX:self.repeatCount;
        //控制动画的速度 匀速 加速 减速
        moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        moveAnimation.delegate = self;
        [self.innerContainer.layer addAnimation:moveAnimation forKey:@"move"];
    }else{
        CGRect rect = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        UILabel *next = [[UILabel alloc] initWithFrame:rect];
        if (self.text) {
            next.text = self.text;
            next.textColor = self.textColor;
            next.font = self.font;
        }else{
            next.attributedText = self.attributedString;
        }

        [self.innerContainer addSubview:next];

        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        moveAnimation.keyTimes = @[@0.,@0.198,@0.868,@1.0];
        moveAnimation.duration = self.bounds.size.width / _rate;
        moveAnimation.values = @[@0,@0.,@(-self.bounds.size.width)];
        moveAnimation.repeatCount = self.repeatCount == 0 ? INT16_MAX : self.repeatCount;
        //速度控制
        moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

        [self.innerContainer.layer addAnimation:moveAnimation forKey:@"move"];
    }
}

- (CGFloat )evaluateContentWidth
{
    CGFloat width = 0.f;
    NSStringDrawingOptions op = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine;
    if (_text.length > 0) {
        CGSize size = [_text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:op attributes:@{NSFontAttributeName:self.font} context:nil].size;
        width = size.width;

    }else if (_attributedString.length >0){
        CGSize size = [_attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:op context:nil].size;
        width = size.width;
    }
    return width;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"start");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        NSLog(@"finsh");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
