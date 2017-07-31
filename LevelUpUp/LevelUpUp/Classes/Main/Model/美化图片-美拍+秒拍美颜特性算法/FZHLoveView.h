//
//  FZHLoveView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/4.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZHLoveView : UIView

/**
 * 比率
 */
@property (nonatomic,assign) CGFloat rate;
/**
 * 填充的颜色
 */
@property (nonatomic,strong) UIColor *fillColor;
/**
 * 线条的颜色
 */
@property (nonatomic,strong) UIColor *strokeColor;
/**
 * 线条的宽度
 */
@property (nonatomic,assign) CGFloat lineWidth;
@end
