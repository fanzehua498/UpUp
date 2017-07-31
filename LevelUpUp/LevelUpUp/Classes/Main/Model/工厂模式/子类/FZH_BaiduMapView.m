//
//  FZH_BaiduMapView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZH_BaiduMapView.h"
#import "FZHBaiduMapView.h"
#import "FZHGaodeMapView.h"


@interface FZH_BaiduMapView ()

@property (nonatomic) FZHBaiduMapView  *baiduView;

@end

@implementation FZH_BaiduMapView

- (UIView *)GetMapView
{
    return _baiduView;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super init]) {
        _baiduView = [[FZHBaiduMapView alloc] initWithFrame:frame];
    }
    return self;
}

@end
