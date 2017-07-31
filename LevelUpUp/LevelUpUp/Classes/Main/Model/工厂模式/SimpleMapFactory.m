//
//  SimpleMapFactory.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/6/7.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "SimpleMapFactory.h"
#import "FZH_BaiduMapView.h"
#import "FZH_GaodeMapView.h"
@implementation SimpleMapFactory

-(id<FZH_MapView>)getMapView:(CGRect)frame type:(int)type
{
    if (type == 1) {
        return [[FZH_BaiduMapView alloc] initWithFrame:frame];
    }
    return [[FZH_GaodeMapView alloc] initWithFrame:frame];
}

@end
