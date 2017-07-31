//
//  FZHAnimationLable.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/3/30.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FZHSpeed) {
    FZHSpeedSlow = -1,
    FZHSpeedMid,
    FZHSpeedFast
};


@interface FZHAnimationLable : UIView
/** label文字 */
@property (nonatomic, strong) NSString  *text;
/** font */
@property (nonatomic, strong) UIFont  *font;
/** 文字颜色 */
@property (nonatomic, strong) UIColor  *textColor;
/** 彩色文字 */
@property (nonatomic, strong) NSAttributedString  *attributedString;
/** 滚动速度 */
@property (nonatomic, assign) FZHSpeed speed;
/** 循环次数 */
@property (nonatomic, assign) NSInteger repeatCount;
/** label间距 */
@property (nonatomic, assign) CGFloat leastDistens;

- (void)reloadView;

@end
