//
//  ShapAnmaintionView.h
//  LevelUpUp
//
//  Created by 范泽华 on 2017/9/30.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShapAnmaintionView : UIView

/** 波浪速度 默认6 */
@property(nonatomic,assign)  CGFloat waveSpeed;
/**  浪高 默认6 */
@property(nonatomic,assign)  CGFloat waveAmplitude;
/** 波浪颜色 默认蓝色 */
@property(nonatomic,strong) UIColor *waveColor;

/** 滚动 */
- (void)wave;
/** 停止 */
- (void)stop;
@end
