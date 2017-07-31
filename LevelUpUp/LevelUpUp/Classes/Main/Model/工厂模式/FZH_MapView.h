//
//  FZH_MapView.h
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FZH_MapView <NSObject>

- (UIView *)GetMapView;

-(instancetype)initWithFrame:(CGRect)frame;

@end
