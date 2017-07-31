//
//  CoinView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/5.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "CoinView.h"

@interface CoinView ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView  *bagView;

@property (nonatomic, strong) UIButton  *animationBtn;
//存放生成的所有金币对应的tag值
@property (nonatomic, strong) NSMutableArray  *coinTagsArr;

@end

static NSInteger coinCount ;

@implementation CoinView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect
{
    [self addSubview:self.bagView];
    self.animationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.animationBtn setTitle:@"打开" forState:UIControlStateNormal];
    [self.animationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.animationBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.animationBtn.frame = CGRectMake(CGRectGetMidX(self.frame) - 20, CGRectGetMidY(self.frame) + 45, 40, 20);
    [self.animationBtn addTarget:self action:@selector(addCoinAnimatin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.animationBtn];
}


- (void)addCoinAnimatin:(UIButton *)btn
{
//    [btn removeFromSuperview];

    //初始化金币的数量
    coinCount = 0;
    for (int i = 0; i<kCoinCountNumber; i++) {
        [self performSelector:@selector(initCoinWithInt:) withObject:[NSNumber numberWithInteger:i] afterDelay:i*0.01];
    }
}

- (void)initCoinWithInt:(NSNumber *)i
{
    UIImageView *coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_coin_%ld",[i integerValue] % 2 + 1]]];
    coin.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    coin.tag = [i integerValue] + 1;

    [self.coinTagsArr addObject:[NSNumber numberWithInteger:coin.tag]];
    [self addSubview:coin];


    ///layer动画
    [self setAnimationWithLaye2:coin];
}

- (void)setAnimationWithLaye:(UIView *)coin
{
    CGFloat duration = 1.6f;

    //抛物线
    CGFloat positionX = coin.layer.position.x; //终点x
    CGFloat positionY = coin.layer.position.y; //终点y

    CGMutablePathRef path = CGPathCreateMutable();

    int width = self.frame.size.width;
    int fromX = arc4random() % width ;//起始位置：x轴上随机生成一个位置
    int height = self.bounds.size.height + coin.frame.size.height;//y轴以屏幕高度为准
    int fromY = arc4random() % (int)positionY;//起始位置：生成位于福袋上方的随机一个y坐标

    CGFloat cpx = positionX + (fromX - positionX)/2; //x控制点
     CGFloat cpy = fromY / 2 - positionY;                //y控制点,确保抛向的最大高度在屏幕内,并且在福袋上方(负数)

    //动画的起始位置
    CGPathMoveToPoint(path, NULL, fromX, height);

    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, positionX, positionY);



    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.speed = 0.1;
    animation.delegate = self;
    [animation setPath:path];
    CFRelease(path);
    path = nil;

    [coin.layer addAnimation:animation forKey:@"position"];
}


- (void)setAnimationWithLaye2:(UIView *)coin
{
    //抛物线
    CGFloat positionX = coin.layer.position.x; //终点x
    CGFloat positionY = coin.layer.position.y; //终点y

     CGMutablePathRef path = CGPathCreateMutable();
    int fromX = 0;
    int fromY = arc4random() % 100 + 100 ;//起始位置：y轴上100~140随机生成一个位置

    CGFloat cpx = positionX + (fromX - positionX)/2; //x控制点
    CGFloat cpy = fromY / 2 - positionY;                //y控制点,确保抛向的最大高度在屏幕内,并且在福袋上方(负数)

    CGFloat cpx2 = 200;
    CGFloat cpy2 = 100;

    //动画的起始位置
    CGPathMoveToPoint(path, NULL, fromX, fromY);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, cpx2, cpy2);
//    CGPathMoveToPoint(path, NULL, cpx2, cpy2);
    CGPathAddQuadCurveToPoint(path, NULL, 300+ arc4random() % 100, cpy2, positionX, positionY);


//    CGPathAddCurveToPoint(path, NULL, cpx, cpy, cpx2, cpy2, positionX, positionY);


    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.speed = 0.1;
    animation.delegate = self;
    [animation setPath:path];
    CFRelease(path);
    path = nil;

    [coin.layer addAnimation:animation forKey:@"position"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        UIView *coin =[self viewWithTag:[[self.coinTagsArr firstObject] integerValue]];
        [coin removeFromSuperview];
        [self.coinTagsArr removeObjectAtIndex:0];

        //全部金币完成动画后执行
        if (++coinCount == kCoinCountNumber) {

            [self shakeAnimation];
        }
    }
}
//福袋晃动动画
- (void)shakeAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:- 0.2];
    animation.toValue = [NSNumber numberWithFloat:0.2];
    animation.duration = 0.1;
    animation.autoreverses = YES;
    animation.repeatCount = 4;
    [self.bagView.layer addAnimation:animation forKey:@"shakeAnimation"];

    [UIView animateWithDuration:4 animations:^{
//        [self.bagView setNeedsDisplay];
    }];
}

-(NSMutableArray *)coinTagsArr
{
    if (!_coinTagsArr) {
        _coinTagsArr = [NSMutableArray array];
    }
    return _coinTagsArr;
}

-(UIImageView *)bagView
{
    if (!_bagView) {
        _bagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_hongbao_bags"]];
        _bagView.frame = CGRectMake(CGRectGetMidX(self.frame) - 40, CGRectGetMidY(self.frame) - 40, 80, 80);
    }
    return _bagView;
}

@end
