//
//  CircularProgressView.h
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//  QQ:20118368
//  http://nijino_saki.blog.163.com

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol CircularProgressDelegate;

@interface CircularProgressView : UIView
{
    UILabel *centerLabel;
    UILabel *perLabel;
    UILabel *titleLabel;
    
    /////距离开标和倒计时
    UILabel *kaibiaoLabel;
    
    UILabel *dayAfter; /////后缀 “天后”
    
}
@property (nonatomic,retain) UILabel *timeDownLabel;

@property (nonatomic,retain) UILabel *daysLabel;

@property (nonatomic,retain) NSString *style; /////one第一个 two第二个。。。。

@property (nonatomic,assign) double processValue;

@property (assign, nonatomic) id <CircularProgressDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
          processValue:(double)value
              style:(NSString *)style;


-(void)setprocessValue:(double)processValue;


@end

@protocol CircularProgressDelegate <NSObject>

- (void)didUpdateProgressView;

@end