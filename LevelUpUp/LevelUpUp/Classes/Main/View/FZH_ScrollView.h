//
//  FZH_ScrollView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/6.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//  无限轮播滚动

#import <UIKit/UIKit.h>

@interface FZH_ScrollView : UIView
@property (nonatomic, strong) NSArray  *imageArr;
//自动轮播
@property (nonatomic, assign) BOOL isScroll;
// 设定自动滚动间隔
@property (nonatomic, assign) NSTimeInterval autoScrollDeley;
- (void)removeTimer;
@end
