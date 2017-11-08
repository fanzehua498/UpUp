//
//  EmitView.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/11/8.
//  Copyright © 2017年 fanzehua. All rights reserved.
//  粒子效果

#import "EmitView.h"

@implementation EmitView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        CAEmitterLayer *emitter = [CAEmitterLayer layer];
//        emitter.frame = self.bounds;
//        [self.layer addSublayer:emitter];
//
//        //configure emitter
//        emitter.renderMode = kCAEmitterLayerAdditive;
//        emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
//
//        //create a particle template
//        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
//        cell.contents = (__bridge id)[UIImage imageNamed:@"Spark.png"].CGImage;
//        cell.birthRate = 150;
//        cell.lifetime = 5.0;
//        cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
//        cell.alphaSpeed = -0.4;
//        cell.velocity = 50;
//        cell.velocityRange = 50;
//        cell.emissionRange = M_PI * 2.0;
//
//        //add particle template to emitter
//        emitter.emitterCells = @[cell];
        
        
        
        
        CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
//        emitter.frame = self.bounds;
         //发射器在xy平面的中心位置
        emitter.emitterPosition = CGPointMake(self.frame.size.width - 50, self.frame.size.height - 50);
        //发射器尺寸
        emitter.emitterSize = CGSizeMake(20, 20);
        //渲染模式
        emitter.renderMode = kCAEmitterLayerUnordered;

        NSMutableArray *cellArr = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            CAEmitterCell *cell = [[CAEmitterCell alloc] init];//发射单元
            cell.birthRate = 1;//粒子速率 默认1/s
            cell.lifetime = arc4random_uniform(4) +1;//粒子存活时间
            cell.lifetimeRange = 1.5;//粒子生存时间容差
            UIImage *cellImage = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30_",i]];
            cell.contents = (__bridge id _Nullable)(cellImage.CGImage);
            cell.velocity = (arc4random_uniform(100) + 100);//粒子运动速度
            cell.velocityRange = 80; //粒子运动速度容差
            //粒子在xy平面的发射角度
            cell.emissionLongitude = 4.6;
            cell.emissionRange = 0.3; //发射角度容差
            cell.scale = 0.3; //缩放比例
            [cellArr addObject:cell];
        }

        emitter.emitterCells = cellArr;
        [self.layer addSublayer:emitter];

        
//        emitter.hidden = YES;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
