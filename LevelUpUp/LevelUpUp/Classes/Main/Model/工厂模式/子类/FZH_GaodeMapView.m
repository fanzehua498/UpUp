//
//  FZH_GaodeMapView.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZH_GaodeMapView.h"
#import "FZHGaodeMapView.h"
@interface FZH_GaodeMapView ()
@property (nonatomic) FZHGaodeMapView  *gaodemapView;
@end

@implementation FZH_GaodeMapView
- (UIView *)GetMapView{
    return _gaodemapView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        _gaodemapView = [[FZHGaodeMapView alloc] initWithFrame:frame];
    }
    return self;
}

@end
